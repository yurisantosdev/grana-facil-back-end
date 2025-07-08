-- CreateEnum
CREATE TYPE "TipoContasEnum" AS ENUM ('POUPANCA', 'CORRENTO', 'SALARIO');

-- CreateEnum
CREATE TYPE "TipoTransacoesEnum" AS ENUM ('DESPESA', 'RECEITA');

-- CreateTable
CREATE TABLE "usuarios" (
    "uscodigo" TEXT NOT NULL,
    "usnome" TEXT NOT NULL,
    "usemail" TEXT NOT NULL,
    "ussenha" TEXT NOT NULL,
    "usnascimento" TIMESTAMP(3) NOT NULL,
    "usfoto" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "usuarios_pkey" PRIMARY KEY ("uscodigo")
);

-- CreateTable
CREATE TABLE "bancos" (
    "bccodigo" TEXT NOT NULL,
    "bcnome" TEXT NOT NULL,
    "bclogo" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "bancos_pkey" PRIMARY KEY ("bccodigo")
);

-- CreateTable
CREATE TABLE "contas" (
    "ctcodigo" TEXT NOT NULL,
    "ctnome" TEXT NOT NULL,
    "ctbanco" TEXT NOT NULL,
    "cttitular" TEXT NOT NULL,
    "cttipo" "TipoContasEnum" NOT NULL,
    "ctsaldo" DOUBLE PRECISION NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "contas_pkey" PRIMARY KEY ("ctcodigo")
);

-- CreateTable
CREATE TABLE "categorias" (
    "cgcodigo" TEXT NOT NULL,
    "cgnome" TEXT NOT NULL,
    "cgicone" TEXT NOT NULL,
    "cgcor" TEXT NOT NULL,
    "cgpadrao" BOOLEAN NOT NULL DEFAULT false,
    "cgusuario" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "categorias_pkey" PRIMARY KEY ("cgcodigo")
);

-- CreateTable
CREATE TABLE "transacoes" (
    "tscodigo" TEXT NOT NULL,
    "tsusuario" TEXT NOT NULL,
    "tsquando" TIMESTAMP(3) NOT NULL,
    "tstipo" "TipoTransacoesEnum" NOT NULL,
    "tsvalor" DOUBLE PRECISION NOT NULL,
    "tscategoria" TEXT NOT NULL,
    "tsefetuada" BOOLEAN NOT NULL DEFAULT false,
    "tsconta" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "transacoes_pkey" PRIMARY KEY ("tscodigo")
);

-- CreateIndex
CREATE UNIQUE INDEX "usuarios_usemail_key" ON "usuarios"("usemail");

-- CreateIndex
CREATE UNIQUE INDEX "bancos_bcnome_key" ON "bancos"("bcnome");

-- AddForeignKey
ALTER TABLE "contas" ADD CONSTRAINT "contas_cttitular_fkey" FOREIGN KEY ("cttitular") REFERENCES "usuarios"("uscodigo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "contas" ADD CONSTRAINT "contas_ctbanco_fkey" FOREIGN KEY ("ctbanco") REFERENCES "bancos"("bccodigo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "categorias" ADD CONSTRAINT "categorias_cgusuario_fkey" FOREIGN KEY ("cgusuario") REFERENCES "usuarios"("uscodigo") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transacoes" ADD CONSTRAINT "transacoes_tsconta_fkey" FOREIGN KEY ("tsconta") REFERENCES "contas"("ctcodigo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transacoes" ADD CONSTRAINT "transacoes_tsusuario_fkey" FOREIGN KEY ("tsusuario") REFERENCES "usuarios"("uscodigo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "transacoes" ADD CONSTRAINT "transacoes_tscategoria_fkey" FOREIGN KEY ("tscategoria") REFERENCES "categorias"("cgcodigo") ON DELETE RESTRICT ON UPDATE CASCADE;
