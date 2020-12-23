import { Controller, Get } from '@nestjs/common';
import { AppService } from './app.service';
import { ApiService } from './app.service';

@Controller('main')
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }
}

@Controller('apis')
export class ApiController {
  constructor(private readonly apiService: ApiService) {}

  @Get()
  getApiResource(): string {
    return this.apiService.getApiResource();
  }
}
