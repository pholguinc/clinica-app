import { PrimaryGeneratedColumn, Column, Entity } from 'typeorm';

@Entity({ name: 'shift' })
export class History {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'integer' })
  numHistory: number;
}
