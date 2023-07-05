import {
  Body,
  Controller,
  Delete,
  Get,
  Param,
  ParseIntPipe,
  Post,
  Put,
} from '@nestjs/common';
import { ConsultingRoomService } from '../services/consulting-room.service';
import { ApiTags } from '@nestjs/swagger';
import {
  CreateConsultingRoomDto,
  UpdateConsultingRoomDto,
} from '../dto/consulting-room.dto';

@ApiTags('Consulting room')
@Controller('consulting-room')
export class ConsultingRoomController {
  constructor(private consultingRoomService: ConsultingRoomService) {}

  @Get()
  findAll() {
    return this.consultingRoomService.findAll();
  }

  @Post()
  create(@Body() payload: CreateConsultingRoomDto) {
    return this.consultingRoomService.create(payload);
  }

  @Get(':id')
  get(@Param('id', ParseIntPipe) id: number) {
    return this.consultingRoomService.findOne(id);
  }

  @Put(':id')
  update(
    @Param('id', ParseIntPipe) id: number,
    @Body() payload: UpdateConsultingRoomDto,
  ) {
    return this.consultingRoomService.update(id, payload);
  }

  @Delete(':id')
  remove(@Param('id', ParseIntPipe) id: number) {
    return this.consultingRoomService.remove(+id);
  }
}
