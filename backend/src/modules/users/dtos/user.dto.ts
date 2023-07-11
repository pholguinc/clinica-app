import {
  IsString,
  IsNotEmpty,
  IsEmail,
  Length,
  IsOptional,
  IsPositive,
} from 'class-validator';
import { PartialType, ApiProperty } from '@nestjs/swagger';

export class CreateUserDto {
  @IsString()
  @IsEmail()
  @ApiProperty({ description: 'the email of user' })
  readonly email: string;

  @IsString()
  @ApiProperty({ description: 'the email of user' })
  readonly name: string;

  @IsString()
  @ApiProperty()
  readonly lastname_pater: string;

  @IsString()
  @ApiProperty()
  readonly lastname_mater: string;

  @IsString()
  @ApiProperty()
  readonly num_doc: string;

  @IsString()
  @ApiProperty()
  readonly phone: string;

  @IsString()
  @ApiProperty()
  readonly address: string;

  @IsString()
  @IsNotEmpty()
  @Length(6)
  @ApiProperty()
  password: string;

  @IsNotEmpty()
  @ApiProperty()
  readonly role: string;
}

export class UpdateUserDto extends PartialType(CreateUserDto) {}
