import { MigrationInterface, QueryRunner } from "typeorm";

export class Migrations1688945378406 implements MigrationInterface {
    name = 'Migrations1688945378406'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "shift" DROP COLUMN "description"`);
        await queryRunner.query(`ALTER TABLE "shift" DROP COLUMN "DateInit"`);
        await queryRunner.query(`ALTER TABLE "shift" DROP COLUMN "DateEnd"`);
        await queryRunner.query(`ALTER TABLE "shift" DROP COLUMN "numHistory"`);
        await queryRunner.query(`ALTER TABLE "shift" ADD "numHistory" integer NOT NULL`);
        await queryRunner.query(`ALTER TABLE "shift" ADD "description" character varying(255) NOT NULL`);
        await queryRunner.query(`ALTER TABLE "shift" ADD "DateInit" TIME NOT NULL`);
        await queryRunner.query(`ALTER TABLE "shift" ADD "DateEnd" TIME NOT NULL`);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`ALTER TABLE "shift" DROP COLUMN "DateEnd"`);
        await queryRunner.query(`ALTER TABLE "shift" DROP COLUMN "DateInit"`);
        await queryRunner.query(`ALTER TABLE "shift" DROP COLUMN "description"`);
        await queryRunner.query(`ALTER TABLE "shift" DROP COLUMN "numHistory"`);
        await queryRunner.query(`ALTER TABLE "shift" ADD "numHistory" integer NOT NULL`);
        await queryRunner.query(`ALTER TABLE "shift" ADD "DateEnd" TIME NOT NULL`);
        await queryRunner.query(`ALTER TABLE "shift" ADD "DateInit" TIME NOT NULL`);
        await queryRunner.query(`ALTER TABLE "shift" ADD "description" character varying(255) NOT NULL`);
    }

}
