/* eslint-disable @typescript-eslint/no-unused-vars */
/* eslint-disable prettier/prettier */
import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { PrismaService } from '../prisma.service';
import { randomUUID } from 'crypto';
import { CategoriasType } from 'src/types/CategoriasType';

@Injectable()
export class CategoriasServices {
  // eslint-disable-next-line prettier/prettier
  constructor(readonly prisma: PrismaService) { }

  async create(categoria: CategoriasType) {
    try {
      await this.prisma.$transaction(async (prisma) => {

        await prisma.categorias.create({
          data: {
            cgcodigo: randomUUID(),
            cgcor: categoria.cgcor,
            cgicone: categoria.cgicone,
            cgnome: categoria.cgnome,
            cgpadrao: categoria.cgpadrao,
            cgusuario: categoria.cgusuario,
          },
        });
      });

      return { status: true, message: 'Categoria cadastrada com sucesso!' };
    } catch (error) {
      const errorMessage =
        error instanceof HttpException
          ? error.getResponse()
          : 'Não foi possível criar a categoria, por favor tente novamente!';

      throw new HttpException({ status: false, error: errorMessage }, HttpStatus.FORBIDDEN);
    }
  }

  async update(categoria: CategoriasType) {
    try {
      await this.prisma.$transaction(async (prisma) => {

        await prisma.categorias.update({
          where: {
            cgcodigo: categoria.cgcodigo,
          },
          data: {
            cgcor: categoria.cgcor,
            cgicone: categoria.cgicone,
            cgnome: categoria.cgnome,
            cgpadrao: categoria.cgpadrao,
          },
        });
      });

      return { status: true, message: 'Categoria atualizada com sucesso!' };
    } catch (error) {
      const errorMessage =
        error instanceof HttpException
          ? error.getResponse()
          : 'Não foi possível atualizar a categoria, por favor tente novamente!';

      throw new HttpException({ status: false, error: errorMessage }, HttpStatus.FORBIDDEN);
    }
  }

  async findAllAtivas() {
    try {
      let categorias;

      await this.prisma.$transaction(async (prisma) => {
        categorias = await prisma.categorias.findMany({
          where: {
            cgativa: true,
          },
          select: {
            cgcodigo: true,
            cgativa: true,
            cgcor: true,
            cgicone: true,
            cgnome: true,
            cgpadrao: true,
            cgusuario: true,
            usuario: {
              select: {
                uscodigo: true,
                usnome: true,
              }
            },
          }
        });
      });

      return { status: true, message: 'Categorias consultadas com sucesso!', categorias };
    } catch (error) {
      const errorMessage =
        error instanceof HttpException
          ? error.getResponse()
          : 'Não foi possível consultar as categorias, por favor tente novamente!';

      throw new HttpException({ status: false, error: errorMessage }, HttpStatus.FORBIDDEN);
    }
  }

  async findAll() {
    try {
      let categorias;

      await this.prisma.$transaction(async (prisma) => {
        categorias = await prisma.categorias.findMany({
          select: {
            cgcodigo: true,
            cgativa: true,
            cgcor: true,
            cgicone: true,
            cgnome: true,
            cgpadrao: true,
            cgusuario: true,
            usuario: {
              select: {
                uscodigo: true,
                usnome: true,
              }
            },
          }
        });
      });

      return { status: true, message: 'Categorias consultadas com sucesso!', categorias };
    } catch (error) {
      const errorMessage =
        error instanceof HttpException
          ? error.getResponse()
          : 'Não foi possível consultar as categorias, por favor tente novamente!';

      throw new HttpException({ status: false, error: errorMessage }, HttpStatus.FORBIDDEN);
    }
  }
}
