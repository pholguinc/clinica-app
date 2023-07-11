import { MigrationInterface, QueryRunner } from "typeorm";

export class Migrations1689066619938 implements MigrationInterface {
    name = 'Migrations1689066619938'

    public async up(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`
            ALTER TABLE "shift" DROP COLUMN "description"
        `);
        await queryRunner.query(`
            ALTER TABLE "shift" DROP COLUMN "DateInit"
        `);
        await queryRunner.query(`
            ALTER TABLE "shift" DROP COLUMN "DateEnd"
        `);
        await queryRunner.query(`
            ALTER TABLE "shift" DROP COLUMN "numHistory"
        `);
        await queryRunner.query(`
            ALTER TABLE "date"
            ADD "userId" integer
        `);
        await queryRunner.query(`
            ALTER TABLE "shift"
            ADD "numHistory" integer NOT NULL
        `);
        await queryRunner.query(`
            ALTER TABLE "shift"
            ADD "description" character varying(255) NOT NULL
        `);
        await queryRunner.query(`
            ALTER TABLE "shift"
            ADD "DateInit" TIME NOT NULL
        `);
        await queryRunner.query(`
            ALTER TABLE "shift"
            ADD "DateEnd" TIME NOT NULL
        `);
        await queryRunner.query(`
            ALTER TABLE "date"
            ADD CONSTRAINT "FK_c679d3dba35a927b3a9d603e3be" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE NO ACTION ON UPDATE NO ACTION
        `);
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
        await queryRunner.query(`
            ALTER TABLE "date" DROP CONSTRAINT "FK_c679d3dba35a927b3a9d603e3be"
        `);
        await queryRunner.query(`
            ALTER TABLE "shift" DROP COLUMN "DateEnd"
        `);
        await queryRunner.query(`
            ALTER TABLE "shift" DROP COLUMN "DateInit"
        `);
        await queryRunner.query(`
            ALTER TABLE "shift" DROP COLUMN "description"
        `);
        await queryRunner.query(`
            ALTER TABLE "shift" DROP COLUMN "numHistory"
        `);
        await queryRunner.query(`
            ALTER TABLE "date" DROP COLUMN "userId"
        `);
        await queryRunner.query(`
            ALTER TABLE "shift"
            ADD "numHistory" integer NOT NULL
        `);
        await queryRunner.query(`
            ALTER TABLE "shift"
            ADD "DateEnd" TIME NOT NULL
        `);
        await queryRunner.query(`
            ALTER TABLE "shift"
            ADD "DateInit" TIME NOT NULL
        `);
        await queryRunner.query(`
            ALTER TABLE "shift"
            ADD "description" character varying(255) NOT NULL
        `);
    }

}
