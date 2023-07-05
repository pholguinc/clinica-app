import { PartialType } from '@nestjs/swagger';

export class CreateDateDto {}

export class UpdateDateDto extends PartialType(CreateDateDto) {}
