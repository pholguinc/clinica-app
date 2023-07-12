import { ConsultingRoom } from '../../consulting-room/entities/consulting-room.entity';
import { User } from '../../users/entities/user.entity';
import {
  Column,
  Entity,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';

@Entity({ name: 'date' })
export class AppointmentDate {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'time' })
  DateInit: string;

  @Column({ type: 'time' })
  DateEnd: string;

  @ManyToOne(() => User, (user) => user.dates)
  user: User;

  @ManyToOne(() => ConsultingRoom, (consultingRoom) => consultingRoom.dates)
  consultingRoom: ConsultingRoom;
}
