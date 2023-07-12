import { ApiProperty, PartialType } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

export class CreateTypeDateDto {
  @IsString()
  @IsNotEmpty()
  @ApiProperty({ description: 'Nombre del tipo de cita' })
  name: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  description: string;
}

export class UpdateTypeDateDto extends PartialType(CreateTypeDateDto) {}
