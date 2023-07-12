import { MigrationInterface, QueryRunner } from "typeorm";

export class Migration1689145051432 implements MigrationInterface {
    name = 'Migration1689145051432'

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
    }

    public async down(queryRunner: QueryRunner): Promise<void> {
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
