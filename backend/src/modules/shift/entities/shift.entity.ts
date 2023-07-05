import { PrimaryGeneratedColumn, Column, Entity } from 'typeorm';

@Entity({ name: 'shift' })
export class Shift {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'varchar', length: 255 })
  description: string;

  @Column({ type: 'time' })
  DateInit: string;

  @Column({ type: 'time' })
  DateEnd: string;
}
