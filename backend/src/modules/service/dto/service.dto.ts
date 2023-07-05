import { ApiProperty, PartialType } from '@nestjs/swagger';
import { IsNotEmpty, IsString } from 'class-validator';

export class CreateServiceDto {
  @IsString()
  @IsNotEmpty()
  @ApiProperty({ description: 'Nombre del consultorio' })
  name: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  description: string;
}

export class UpdateServiceDto extends PartialType(CreateServiceDto) {}
