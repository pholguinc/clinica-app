import { IsString, IsNotEmpty, IsNumber } from 'class-validator';
import { PartialType, ApiProperty } from '@nestjs/swagger';
export class CreateConsultingRoomDto {
  @IsString()
  @IsNotEmpty()
  @ApiProperty({ description: 'Nombre del consultorio' })
  name: string;

  @IsString()
  @IsNotEmpty()
  @ApiProperty()
  description: string;

  @IsNumber()
  @IsNotEmpty()
  numConsult: number;
}

export class UpdateConsultingRoomDto extends PartialType(
  CreateConsultingRoomDto,
) {}
