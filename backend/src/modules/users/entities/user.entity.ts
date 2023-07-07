import { PrimaryGeneratedColumn, Column, Entity } from 'typeorm';
import { DateAt } from '../../../database/date-at.entity';
import { JoinColumn, OneToOne } from 'typeorm';

import { Exclude } from 'class-transformer';

@Entity({ name: 'users' })
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'varchar', length: 255 })
  email: string;

  @Column({ type: 'varchar', length: 255 })
  name: string;

  @Exclude()
  @Column({ type: 'varchar', length: 255 })
  password: string;

  @Column({ type: 'varchar', length: 100 })
  role: string;

  @Column(() => DateAt, { prefix: false })
  register: DateAt;
}
