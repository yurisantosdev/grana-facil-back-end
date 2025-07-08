-- CreateTable
CREATE TABLE "codigosRecuperacaoSenhas" (
    "crccodigo" TEXT NOT NULL,
    "crctoken" INTEGER NOT NULL,
    "crcusuario" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "codigosRecuperacaoSenhas_pkey" PRIMARY KEY ("crccodigo")
);

-- CreateIndex
CREATE UNIQUE INDEX "codigosRecuperacaoSenhas_crctoken_key" ON "codigosRecuperacaoSenhas"("crctoken");

-- AddForeignKey
ALTER TABLE "codigosRecuperacaoSenhas" ADD CONSTRAINT "codigosRecuperacaoSenhas_crcusuario_fkey" FOREIGN KEY ("crcusuario") REFERENCES "usuarios"("uscodigo") ON DELETE RESTRICT ON UPDATE CASCADE;
