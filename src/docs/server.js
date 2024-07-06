import fastify from "fastify";
import fastifyRedis from "@fastify/redis";

const PORT = 3124;

const app = fastify({ logger: false });
// Register the fastify-redis plugin
app.register(fastifyRedis, {
    host: '127.0.0.1',
    port: 6379
});

// Custom 404 handler
app.setNotFoundHandler((request, reply) => {
    reply
        .status(404)
        .send({ message: 'The route you are looking for does not exist' });
});

// Endpoint to get a document by key
app.get('/docs/get', async (request, reply) => {
    const key = request.query.key;
    const value = await app.redis.get(key);

    if (value) {
        reply.send(value);
    } else {
        reply.send(null);
    }
});

// Endpoint to set a document by key
app.post('/docs/set', async (request, reply) => {
    const key = request.query.key;
    const data = request.body;
    await app.redis.set(key, JSON.stringify(data));
    reply.send({ status: 'ok' });
});

// Endpoint to delete a document by key
app.delete('/docs/delete', async (request, reply) => {
    const key = request.query.key;
    await app.redis.del(key);
    reply.send({ status: 'ok' });
});

// Start the server
const start = async () => {
    try {
        await app.listen({ port: PORT });
        app.log.info(`Server running at http://localhost:3000/`);
    } catch (err) {
        app.log.error(err);
        process.exit(1);
    }
};
start();