const fastify = require('fastify')({ logger: true });
const fastifyRedis = require('@fastify/redis');

// Register the fastify-redis plugin
fastify.register(fastifyRedis, {
    host: '127.0.0.1',
    port: 6379
});

// Endpoint to get a document by key
fastify.get('/docs/get', async (request, reply) => {
    const key = request.query.key;
    const value = await fastify.redis.get(key);
    if (value) {
        reply.send({ data: JSON.parse(value) });
    } else {
        reply.code(404).send({ error: 'Key not found' });
    }
});

// Endpoint to set a document by key
fastify.post('/docs/set', async (request, reply) => {
    const key = request.query.key;
    const data = request.body;
    await fastify.redis.set(key, JSON.stringify(data));
    reply.send({ status: 'ok' });
});

// Endpoint to delete a document by key
fastify.delete('/docs/delete', async (request, reply) => {
    const key = request.query.key;
    await fastify.redis.del(key);
    reply.send({ status: 'ok' });
});

// Start the server
const start = async () => {
    try {
        await fastify.listen({ port: 3000 });
        fastify.log.info(`Server running at http://localhost:3000/`);
    } catch (err) {
        fastify.log.error(err);
        process.exit(1);
    }
};
start();