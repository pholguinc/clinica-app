import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ name: 'date' })
export class Date {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'time' })
  DateInit: string;

  @Column({ type: 'time' })
  DateEnd: string;
}
