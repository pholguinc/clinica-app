import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';
import { DateAt } from '../../../database/date-at.entity';

@Entity({ name: 'medicine' })
export class Medicine {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'varchar', length: 255 })
  name: string;

  @Column({ type: 'varchar', length: 255 })
  description: string;

  @Column(() => DateAt, { prefix: false })
  register: DateAt;
}
