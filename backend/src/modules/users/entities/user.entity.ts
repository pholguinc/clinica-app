import { PrimaryGeneratedColumn, Column, Entity, OneToMany } from 'typeorm';
import { DateAt } from '../../../database/date-at.entity';
import { JoinColumn, OneToOne } from 'typeorm';

import { Exclude } from 'class-transformer';
import { Date } from '../../date/entities/date.entity';

@Entity({ name: 'users' })
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'varchar', length: 255 })
  email: string;

  @Column({ type: 'varchar', length: 255 })
  name: string;

  @Column({ type: 'varchar', length: 255 })
  lastname_pater: string;

  @Column({ type: 'varchar', length: 255 })
  lastname_mater: string;

  @Column({ type: 'varchar', length: 255 })
  num_doc: string;

  @Column({ type: 'varchar', length: 255 })
  phone: string;

  @Column({ type: 'varchar', length: 255 })
  address: string;

  @Exclude()
  @Column({ type: 'varchar', length: 255 })
  password: string;

  @Column({ type: 'varchar', length: 100 })
  role: string;

  @Column(() => DateAt, { prefix: false })
  register: DateAt;

  @OneToMany(() => Date, (date) => date.user)
  dates: Date[];
}
