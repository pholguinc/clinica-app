import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Delete,
  ParseIntPipe,
  Put,
} from '@nestjs/common';
import { TypeDateService } from '../service/type-date.service';
import {
  CreateTypeDateDto,
  UpdateTypeDateDto,
} from '../dto/create-type-date.dto';

@Controller('type-date')
export class TypeDateController {
  constructor(private readonly typeDateService: TypeDateService) {}

  @Post()
  create(@Body() createTypeDateDto: CreateTypeDateDto) {
    return this.typeDateService.create(createTypeDateDto);
  }

  @Get()
  findAll() {
    return this.typeDateService.findAll();
  }

  @Get(':id')
  get(@Param('id', ParseIntPipe) id: number) {
    return this.typeDateService.findOne(id);
  }

  @Put(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() payload: UpdateTypeDateDto,
  ) {
    return this.typeDateService.update(id, payload);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.typeDateService.remove(+id);
  }
}
