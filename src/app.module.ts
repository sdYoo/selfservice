import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { ApiController } from './app.controller';
import { AppService } from './app.service';
import { ApiService } from './app.service';

@Module({
  imports: [],
  controllers: [AppController, ApiController],
  providers: [AppService, ApiService],
})
export class AppModule {}
