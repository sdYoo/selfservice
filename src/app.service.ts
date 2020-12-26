import { Injectable, Param } from '@nestjs/common';

@Injectable()
export class AppService {
  getHello(): string {
    return 'Hello World!';
  }
}

@Injectable()
export class AccountService {
  getAccountInfo(cspId): string {
    return cspId + ' 초기 인프라 생성 완료';
  }
}

@Injectable()
export class InfraService {
  getCloudInfra(cspId): string {
    return cspId + ' 초기 인프라 생성 완료';
  }
}
