import { IsNotEmpty, IsString } from 'class-validator';
import { PartialType, ApiProperty } from '@nestjs/swagger';

export class CreateShiftDto {
  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  description: string;

  @IsString()
  @ApiProperty({ description: 'Fecha de inicio del turno', example: 'HH:mm' })
  DateInit: string;

  @IsString()
  @ApiProperty({ description: 'Fecha de fin del turno', example: 'HH:mm' })
  DateEnd: string;
}

export class UpdateShiftDto extends PartialType(CreateShiftDto) {}
