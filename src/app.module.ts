import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { ApiController } from './app.controller';
import { AppService } from './app.service';
import { ApiService } from './app.service';
import { ServeStaticModule } from '@nestjs/serve-static';
import { join } from 'path';

@Module({
  imports: [
    ServeStaticModule.forRoot({
      rootPath: join(__dirname, '..', 'client'),
      exclude: ['/api*'],
    }),
  ],
  controllers: [AppController, ApiController],
  providers: [AppService, ApiService],
})
export class AppModule {}
