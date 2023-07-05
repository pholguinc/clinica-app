import { NestFactory, Reflector } from '@nestjs/core';
import { AppModule } from './app.module';
import { ConfigService } from '@nestjs/config';
import { ClassSerializerInterceptor, ValidationPipe } from '@nestjs/common';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.useGlobalPipes(
    new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
      transformOptions: {
        enableImplicitConversion: true,
      },
    }),
  );

  app.useGlobalInterceptors(new ClassSerializerInterceptor(app.get(Reflector)));

  const config = new DocumentBuilder()
    .setTitle('API')
    .setDescription('APP Citas Médicas')
    .setVersion('1.0')
    .addTag('Users', 'Endpoints relacionados con usuarios')
    .addTag('Auth', 'Endpoints relacionados con la autenticación')
    .addBearerAuth(
      {
        type: 'http',
        scheme: 'bearer',
        bearerFormat: 'JWT',
        name: 'JWT',
        description: 'Enter JWT Token',
        in: 'header',
      },
      'JWT-auth',
    )

    .addTag('Shift', 'Endpoints relacionados con los turnos de los doctores')
    .addTag('Service', 'Endpoints relacionados con los servicios')
    .addTag('Consulting room', 'Endpoints relacionados con los consultorios')
    .addTag('Medicines', 'Endpoints relacionados a las medicinas')
    .addTag('Sickness', 'Endpoints relacionados a las enfermedades')
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('docs', app, document);

  app.enableCors();
  const configService = app.get(ConfigService);
  // server port
  const port = +configService.get<number>(process.env.PORT) || 3000;
  await app.listen(port);
}
bootstrap();
