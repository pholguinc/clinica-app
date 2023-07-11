import { User } from '../../users/entities/user.entity';
import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';

@Entity({ name: 'date' })
export class Date {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'time' })
  DateInit: string;

  @Column({ type: 'time' })
  DateEnd: string;

  @ManyToOne(() => User, (user) => user.dates)
  user: User;
}
