import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AccountController } from './app.controller';
import { InfraController } from './app.controller';
import { AppService } from './app.service';
import { AccountService } from './app.service';
import { InfraService } from './app.service';

@Module({
  imports: [],
  controllers: [AppController, AccountController, InfraController],
  providers: [AppService, AccountService, InfraService],
})
export class AppModule {}
