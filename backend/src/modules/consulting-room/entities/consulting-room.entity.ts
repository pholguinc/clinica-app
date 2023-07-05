import { DateAt } from '../../../database/date-at.entity';
import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ name: 'consulting_room' })
export class ConsultingRoom {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'varchar', length: 255 })
  name: string;

  @Column({ type: 'varchar', length: 255 })
  description: string;

  @Column({ type: 'int', default: 0 })
  numConsult: number;

  @Column(() => DateAt, { prefix: false })
  register: DateAt;
}
