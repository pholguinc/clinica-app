import {
  Controller,
  Get,
  Body,
  Param,
  Delete,
  ParseIntPipe,
  Post,
  Put,
} from '@nestjs/common';
import { ServiceService } from '../services/service.service';
import { CreateServiceDto, UpdateServiceDto } from '../dto/service.dto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Service')
@Controller('service')
export class ServiceController {
  constructor(private readonly serviceService: ServiceService) {}

  @Post()
  create(@Body() createMedicineDto: CreateServiceDto) {
    return this.serviceService.create(createMedicineDto);
  }

  @Get()
  findAll() {
    return this.serviceService.findAll();
  }

  @Get(':id')
  get(@Param('id', ParseIntPipe) id: number) {
    return this.serviceService.findOne(id);
  }

  @Put(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() payload: UpdateServiceDto,
  ) {
    return this.serviceService.update(id, payload);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.serviceService.remove(+id);
  }
}
