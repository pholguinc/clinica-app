import { Controller, Get, Post, Req, UseGuards } from '@nestjs/common';
import { Request } from 'express';
import { AuthGuard } from '@nestjs/passport';

import { AuthService } from '../services/auth.service';
import { User } from '../../modules/users/entities/user.entity';
import { UsersService } from '../../modules/users/services/users.service';

@Controller('auth')
export class AuthController {
  constructor(
    private authService: AuthService,
    private usersService: UsersService,
  ) {}

  @UseGuards(AuthGuard('local'))
  @Post('login')
  async login(@Req() req) {
    const user = req.user as User;
    const userProfile = await this.usersService.findOne(user.id);
    const token = this.authService.generateJWT(userProfile);
    return { userProfile, token };
  }
}
