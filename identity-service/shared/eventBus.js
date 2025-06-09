// /shared/eventBus.js
const amqp = require('amqplib');
require('dotenv').config();

const AMQP_PROTOCOL = process.env.AMQP_PROTOCOL || 'amqp';
const AMQP_HOST = process.env.AMQP_HOST.replace(/^https?:\/\//, '');
const AMQP_PORT = process.env.AMQP_PORT || 5672;
const AMQP_USER = process.env.AMQP_USER;
const AMQP_PASSWORD = process.env.AMQP_PASSWORD;

const AMQP_URL = `${AMQP_PROTOCOL}://${AMQP_USER}:${AMQP_PASSWORD}@${AMQP_HOST}:${AMQP_PORT}`;

class EventBus {
  constructor() {
    this.connection = null;
    this.channel = null;
    this.connected = false;
  }

  async connect() {
    if (!this.connected) {
      this.connection = await amqp.connect(AMQP_URL);
      this.channel = await this.connection.createChannel();
      await this.channel.assertQueue('notifications', { durable: true });
      this.connected = true;
    }
  }

  async publish(queue, message) {
    await this.connect();
    this.channel.sendToQueue(queue, Buffer.from(JSON.stringify(message)), { persistent: true });
  }

  async consume(queue, callback) {
    await this.connect();
    this.channel.consume(queue, async (msg) => {
      if (msg !== null) {
        try {
          const data = JSON.parse(msg.content.toString());
          await callback(data);
          this.channel.ack(msg);
        } catch (err) {
          this.channel.nack(msg, false, false);
        }
      }
    });
  }
}

// Exemplo de uso (pode remover se for usar só como módulo):
if (require.main === module) {
  (async () => {
    const eventBus = new EventBus();

    // Exemplo: publicar uma notificação
    await eventBus.publish('notifications', {
      type: 'REGISTRATION',
      user_id: 1,
      content: 'Bem-vindo!'
    });

    // Exemplo: consumir notificações
    eventBus.consume('notifications', async (data) => {
      console.log('Notificação recebida:', data);
      // Aqui você pode processar a notificação
    });
  })();
}

module.exports = new EventBus();
