import { Injectable } from '@nestjs/common';
//import * as bcrypt from 'bcrypt';
import * as bcrypt from 'bcryptjs';
import { JwtService } from '@nestjs/jwt';

import { UsersService } from '../../modules/users/services/users.service';
import { User } from '../../modules/users/entities/user.entity';
import { PayloadToken } from '../models/token.model';

@Injectable()
export class AuthService {
  constructor(
    private usersService: UsersService,
    private jwtService: JwtService,
  ) {}

  /**
  
   * @param email
   * @param password
   * TODO: Valida las credenaciales de autneticación
   * @returns
   */

  async validateUser(email: string, password: string) {
    const user = await this.usersService.findByEmail(email);

    if (user) {
      const isMatch = await bcrypt.compare(password, user.password);
      if (isMatch) {
        return user;
      }
    }
    return null;
  }

  /**
   *
   * @param user
   * @returns
   * TODO: Genera el jwtTOken del usuario
   */

  generateJWT(user: User) {
    const payload: PayloadToken = { role: user.role, sub: user.id };
    return {
      access_token: this.jwtService.sign(payload),
      user,
    };
  }
}
