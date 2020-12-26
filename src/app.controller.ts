import { Get, Controller, Res, Render, Param } from '@nestjs/common';
import { AppService } from './app.service';
import { AccountService } from './app.service';
import { InfraService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  @Render('index')
  root() {
    return { message: this.appService.getHello() };
  }
}

@Controller('account')
export class AccountController {
  constructor(private readonly accountService: AccountService) {}

  @Get(':cspId')
  @Render('index')
  createAccount(@Param('cspId') cspId: string) {
    console.log(cspId);
    return { message: this.accountService.getAccountInfo(cspId) };
  }
}

@Controller('infra')
export class InfraController {
  constructor(private readonly infraService: InfraService) {}

  @Get(':cspId')
  @Render('index')
  creatInfra(@Param('cspId') cspId: string) {
    console.log(cspId);
    return { message: this.infraService.getCloudInfra(cspId) };
  }
}
