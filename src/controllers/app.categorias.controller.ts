/* eslint-disable @typescript-eslint/no-unused-vars */
// eslint-disable-next-line @typescript-eslint/no-unused-vars
import {
  Body,
  Controller,
  Get,
  Param,
  Post,
  Request,
  UseGuards,
} from '@nestjs/common';
import { AuthGuard } from '@nestjs/passport';
import { CategoriasServices } from 'src/services/app.categorias.service';
import { CategoriasType } from 'src/types/CategoriasType';

@Controller()
export class CategoriasController {
  // eslint-disable-next-line prettier/prettier
  constructor(private service: CategoriasServices) { }

  @UseGuards(AuthGuard('jwt'))
  @Post('categorias/create')
  async create(@Request() @Body() Body: CategoriasType) {
    return this.service.create(Body);
  }

  @UseGuards(AuthGuard('jwt'))
  @Post('categorias/update')
  async update(@Request() @Body() Body: CategoriasType) {
    return this.service.update(Body);
  }

  @UseGuards(AuthGuard('jwt'))
  @Get('categorias/findAllAtivas')
  async findAllAtivas() {
    return this.service.findAllAtivas();
  }

  @UseGuards(AuthGuard('jwt'))
  @Post('categorias/findAll')
  async findAll() {
    return this.service.findAll();
  }
}
