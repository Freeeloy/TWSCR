gg.setVisible(false) -- FECHAR O GAMEGUARDIAN

---- FUNÇÃO DE LINGUAGEM
-- Definição do idioma: 1 para Português, 2 para Inglês
local lang = 1  
local premiuns = false
local marketinf = true
local marketnext = false

UltimoMenu = nil  -- Variável para armazenar o último menu acessado
local SAVE_LANG_FILE = "/sdcard/Lang.txt" 
local SAVE_KEY_FILE = "/sdcard/Key.cfg" 

-- Função para salvar o menu
function SalvarUltimoMenu(menu_tipo)
  UltimoMenu = menu_tipo
end

-- Função para selecionar o idioma e traduzir textos dinamicamente
function lng(...)
  local list = {...}
  
  -- Se for chamada sem argumentos, abre o menu de seleção de idioma
  if #list == 0 then
      local opcoes = { "🇧🇷 Português", "🇺🇸 English", "🇪🇸 Español", "🇮🇩 Indonesia" }
      local escolha = gg.choice(opcoes, nil, lng("ESCOLHA UMA OPÇÃO", "CHOOSE AN OPTION"))

      if escolha then
          lang = escolha
          salvarIdioma(lang)  -- Salva o idioma escolhido
      end
      return
  end

  -- Retorna o texto no idioma selecionado ou o primeiro por padrão
  return list[lang] or list[1]
end

-- Função para salvar a linguagem escolhida no arquivo
function salvarIdioma(lang)
  local file = io.open(SAVE_LANG_FILE, "w+")
  if file then
      file:write(lang)  -- Grava o idioma no arquivo
      file:close()
  end
end

-- Função para carregar a linguagem do arquivo
function carregarIdioma()
  local file = io.open(SAVE_LANG_FILE, "r")
  if file then
      local lang = tonumber(file:read("*all"))  -- Lê o idioma do arquivo
      file:close()
      return lang
  end
end

-- Função para apagar a linguagem do arquivo
function apagarIdioma()
  local file = io.open(SAVE_LANG_FILE, "w")  -- Abre o arquivo para escrita (irá apagar o conteúdo)
  if file then
      file:close()  -- Fecha o arquivo imediatamente, apagando seu conteúdo
      os.exit()
  end
end
-- Função para apagar a key do arquivo
function apagarKey()
  os.remove(SAVE_KEY_FILE)
  os.exit()
end

---- FUNÇÃO SET VALORES
function setg(offset, new)
  local table = gg.getResults(40)
  for i = 1, #table do
     table[i]["address"] = table[i]["address"] + offset 
     table[i]["flags"] = gg.TYPE_DWORD 
     table[i]["value"] = new
     table[i]["freezeType"] = gg.FREEZE_NORMAL
     table[i]["freeze"] = true
     gg.addListItems(table)
  end
end
function setd(offset, new)
  local table = gg.getResults(30)
  for i = 1, #table do
     table[i]["address"] = table[i]["address"] + offset 
     table[i]["flags"] = gg.TYPE_DWORD
     table[i]["value"] = new
     table[i]["freeze"] = true
     gg.addListItems(table) 
  end
end
function setd2(offset, new)
  local table = gg.getResults(30)
  for i = 1, #table do
     table[i]["address"] = table[i]["address"] + offset 
     table[i]["flags"] = gg.TYPE_DWORD
     table[i]["value"] = new
     table[i]["freeze"] = false
     gg.addListItems(table) 
     gg.setValues(table)
  end
end
function setf(offset, new)
  local table = gg.getResults(30)
  for i = 1, #table do
     table[i]["address"] = table[i]["address"] + offset 
     table[i]["flags"] = gg.TYPE_FLOAT
     table[i]["value"] = new
     table[i]["freeze"] = true
     gg.addListItems(table) 
  end
end

---- FUNÇÃO DE ESPERA
function wait_for_action()
  gg.setVisible(false)
  repeat gg.sleep(100) until gg.isVisible()
end

--- HACK CONSTRUÇÕES RÁPIDA
function hcr()
  gg.toast(lng("Carregando...", "Loading...", "Cargando...", "Memuat..."))
  gg.clearResults()
  gg.setRanges(gg.REGION_C_ALLOC)
  gg.searchNumber("1599099682;1936682818;1634882676;33;24", gg.TYPE_DWORD)
  gg.refineNumber("24", gg.TYPE_DWORD)

  local results = gg.getResults(1)
  if #results == 0 then
    gg.alert(lng("Erro: Nenhum resultado encontrado!", "Error: No results found!", "Error: ¡No se encontraron resultados!", "Kesalahan: Tidak ada hasil ditemukan!"))
    os.exit()
  end

  local baseAddress = results[1].address - 0x8
  local copiedValues = {}

  for i = 0, 5 do
    table.insert(copiedValues, {
        address = baseAddress + (i * 4),
        flags = gg.TYPE_DWORD
    })
  end

  copiedValues = gg.getValues(copiedValues) -- Mengambil nilai yang disalin

  gg.clearResults()
  gg.searchNumber("30;1599361808", gg.TYPE_DWORD)
  gg.refineNumber("30", gg.TYPE_DWORD)

  local refineResults = gg.getResults(1)
  if #refineResults == 0 then
    gg.alert(lng("Erro: Valores insuficientes na lista!", "Error: Insufficient values in list!", "Error: ¡Valores insuficientes en la lista!", "Kesalahan: Nilai dalam daftar tidak mencukupi!"))
    os.exit()
  end

  local targetAddress = refineResults[1].address - 0x48
  local newValues = {}

  for i, value in ipairs(copiedValues) do
    table.insert(newValues, {
        address = targetAddress + ((i - 1) * 4),
        value = value.value,
        flags = gg.TYPE_DWORD
    })
  end

  table.insert(newValues, {
    address = targetAddress + (6 * 4),
    value = 0,
    flags = gg.TYPE_DWORD
  })

  table.insert(newValues, {
    address = targetAddress + (7 * 4),
    value = 100,
    flags = gg.TYPE_DWORD
  })

  gg.setValues(newValues)
end

---- HACK CELEIRO INFINITO
function hcl()
gg.toast(lng("Carregando...", "Loading...", "Cargando...", "Memuat..."))
gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)
gg.searchNumber("1599099682;1936682818;1634882676;33;23", gg.TYPE_DWORD)
gg.refineNumber("23", gg.TYPE_DWORD)

local results = gg.getResults(1)
if #results == 0 then
    gg.alert(lng("Erro: Nenhum resultado encontrado!", "Error: No results found!", "Error: ¡No se encontraron resultados!", "Kesalahan: Tidak ada hasil ditemukan!"))
    os.exit()
end

local baseAddress = results[1].address - 0x8
local copiedValues = {}

for i = 0, 5 do
    table.insert(copiedValues, {
        address = baseAddress + (i * 4),
        flags = gg.TYPE_DWORD
    })
end

copiedValues = gg.getValues(copiedValues) -- Mengambil nilai yang disalin

gg.clearResults()
gg.searchNumber("30;1599361808", gg.TYPE_DWORD)
gg.refineNumber("30", gg.TYPE_DWORD)

local refineResults = gg.getResults(1)
if #refineResults == 0 then
    gg.alert(lng("Erro: Valores insuficientes na lista!", "Error: Insufficient values in list!", "Error: ¡Valores insuficientes en la lista!", "Kesalahan: Nilai dalam daftar tidak mencukupi!"))
    os.exit()
end

-- Offset ke 0x48
local targetAddress = refineResults[1].address - 0x48

-- Menyalin nilai yang disalin sebelumnya ke alamat ini
local newValues = {}
for i, value in ipairs(copiedValues) do
    table.insert(newValues, {
        address = targetAddress + ((i - 1) * 4),
        value = value.value,
        flags = gg.TYPE_DWORD
    })
end

table.insert(newValues, {
    address = targetAddress + (6 * 4),
    value = 0,
    flags = gg.TYPE_DWORD
})

local options = {"8000", "15000", "30000", "50000", "Sair"}
local choice = gg.choice(options, nil, lng("Selecione um valor:", "Select a value:", "Seleccione un valor:", "Pilih nilai:"))

if choice == nil or choice == #options then
    os.exit()
end

local customValue = tonumber(options[choice])

table.insert(newValues, {
    address = targetAddress + (7 * 4),
    value = customValue,
    flags = gg.TYPE_DWORD
})

gg.setValues(newValues)

end

function skinscp(value)
gg.toast(lng("Carregando...", "Loading...", "Cargando...", "Memuat..."))
gg.clearResults()
gg.setRanges(gg.REGION_C_ALLOC)

if value >= 1 and value <= 12 then
  gg.searchNumber("00007638h;C9B753A1h;32594E72h;B5417CBEh", gg.TYPE_DWORD)
  gg.refineNumber("B5417CBEh", gg.TYPE_DWORD)
elseif value >= 13 and value <= 15 then
  gg.searchNumber("00007638h;6044F71Bh;3B7437C2h;696B5326h;68435F6Eh;656B6369h;65685F6Eh;73616C6Ch;93317718h;DAD42321h;696B5328h::500", gg.TYPE_DWORD)
  gg.refineNumber("696B5328h", gg.TYPE_DWORD)
elseif value >= 16 and value <= 22 then
  gg.searchNumber("4665F97Eh;696B5324h;68535F6Eh;5F706565h;61666544h;00746C75h;00000000h;696B532Ch;68535F6Eh;5F706565h;616E756Ch;32594E72h;00323230h", gg.TYPE_DWORD)
  gg.refineNumber("696B5324h", gg.TYPE_DWORD)
elseif value >= 23 and value <= 27 then
  gg.searchNumber("32796164h;00343230h;00007638h;00007638h;00007638h;00007638h;D1C7C9EEh;C03812A8h;68535F6Eh;655F7069h;74707967h", gg.TYPE_DWORD)
  gg.refineNumber("74707967h", gg.TYPE_DWORD)
elseif value >= 28 and value <= 48 then
  gg.searchNumber("70735F74h;702CDD69h;1B4A5118h;EA15D52Ah;10568E40h;AD932E8Bh", gg.TYPE_DWORD)
  gg.refineNumber("70735F74h", gg.TYPE_DWORD)
elseif value >= 49 and value <= 54 then
  gg.searchNumber("696B532Ah;65485F6Eh;6F63696Ch;EDB0E9EEh", gg.TYPE_DWORD)
  gg.refineNumber("EDB0E9EEh", gg.TYPE_DWORD)
elseif value >= 55 and value <= 85 then
  gg.searchNumber("33;26;1953055504;1734955897::29", gg.TYPE_DWORD)
  gg.refineNumber("26", gg.TYPE_DWORD)
end

local results = gg.getResults(1)
if #results == 0 then
    gg.alert(lng("Erro: Nenhum resultado encontrado!", "Error: No results found!", "Error: ¡No se encontraron resultados!", "Kesalahan: Tidak ada hasil ditemukan!"))
    os.exit()
end

  local baseAddress
  --- Skins Estação Train
  if value == 1 then
    baseAddress = results[1].address + 388
  elseif value == 2 then
    baseAddress = results[1].address + 452 
  elseif value == 3 then
    baseAddress = results[1].address + 516 
  elseif value == 4 then
    baseAddress = results[1].address + 580 
  elseif value == 5 then
    baseAddress = results[1].address + 644 
  elseif value == 6 then
    baseAddress = results[1].address + 708 
  elseif value == 7 then
    baseAddress = results[1].address + 836 
  elseif value == 8 then
    baseAddress = results[1].address + 900 
  elseif value == 9 then
    baseAddress = results[1].address + 964 
  elseif value == 10 then
    baseAddress = results[1].address + 1028 
  elseif value == 11 then
    baseAddress = results[1].address + 1092 
  elseif value == 12 then
    baseAddress = results[1].address + 1156 
  --- Skins Ovelha
  elseif value == 13 then
    baseAddress = results[1].address + 768 
  elseif value == 14 then
    baseAddress = results[1].address + 832 
  elseif value == 15 then
    baseAddress = results[1].address + 896 
  --- Skins Galinha
  elseif value == 16 then
    baseAddress = results[1].address - 128 
  elseif value == 17 then
    baseAddress = results[1].address - 192 
  elseif value == 18 then
    baseAddress = results[1].address - 256 
  elseif value == 19 then
    baseAddress = results[1].address - 320 
  elseif value == 20 then
    baseAddress = results[1].address - 512 
  elseif value == 21 then
    baseAddress = results[1].address - 704 
  elseif value == 22 then
    baseAddress = results[1].address - 832 
  --- Skins Ilha
  elseif value == 23 then
    baseAddress = results[1].address + 628 
  elseif value == 24 then
    baseAddress = results[1].address + 692
  elseif value == 25 then
    baseAddress = results[1].address + 756 
  elseif value == 26 then
    baseAddress = results[1].address + 820 
  elseif value == 27 then
    baseAddress = results[1].address + 1012 
  --- Skins Aeroporto
  elseif value == 28 then
    baseAddress = results[1].address + 52
  elseif value == 29 then
    baseAddress = results[1].address + 116
  elseif value == 30 then
    baseAddress = results[1].address + 180
  --- Skins Helipad
  elseif value == 31 then
    baseAddress = results[1].address + 244
  elseif value == 32 then
    baseAddress = results[1].address + 308
  elseif value == 33 then
    baseAddress = results[1].address + 372
  elseif value == 34 then
    baseAddress = results[1].address + 436
  elseif value == 35 then
    baseAddress = results[1].address + 500
  elseif value == 36 then
    baseAddress = results[1].address + 564
  elseif value == 37 then
    baseAddress = results[1].address + 628
  elseif value == 38 then
    baseAddress = results[1].address + 692
  elseif value == 39 then
    baseAddress = results[1].address + 756
  elseif value == 40 then
    baseAddress = results[1].address + 820
  elseif value == 41 then
    baseAddress = results[1].address + 884
  elseif value == 42 then
    baseAddress = results[1].address + 948
  elseif value == 43 then
    baseAddress = results[1].address + 1012
  elseif value == 44 then
    baseAddress = results[1].address + 1076
  elseif value == 45 then
    baseAddress = results[1].address + 1140
  elseif value == 46 then
    baseAddress = results[1].address + 1204
  elseif value == 47 then
    baseAddress = results[1].address + 1268
  elseif value == 48 then
    baseAddress = results[1].address + 1332
  --- Skins Helicopter
  elseif value == 49 then
    baseAddress = results[1].address + 648
  elseif value == 50 then
    baseAddress = results[1].address + 712
  elseif value == 51 then
    baseAddress = results[1].address + 840
  elseif value == 52 then
    baseAddress = results[1].address + 904
  elseif value == 53 then
    baseAddress = results[1].address + 1032
  elseif value == 54 then
    baseAddress = results[1].address + 1096
  --- Placas Cidade
  elseif value == 55 then
    baseAddress = results[1].address + 72
  elseif value == 56 then
    baseAddress = results[1].address + 152
  elseif value == 57 then
    baseAddress = results[1].address + 232
  elseif value == 58 then
    baseAddress = results[1].address + 312
  elseif value == 58 then
    baseAddress = results[1].address + 392
  elseif value == 59 then
    baseAddress = results[1].address + 472
  elseif value == 60 then
    baseAddress = results[1].address + 552
  elseif value == 61 then
    baseAddress = results[1].address + 632
  elseif value == 62 then
    baseAddress = results[1].address + 712
  elseif value == 63 then
    baseAddress = results[1].address + 792
  elseif value == 64 then
    baseAddress = results[1].address + 872
  elseif value == 65 then
    baseAddress = results[1].address + 952
  elseif value == 66 then
    baseAddress = results[1].address + 1032
  elseif value == 67 then
    baseAddress = results[1].address + 1112
  elseif value == 68 then
    baseAddress = results[1].address + 1272
  elseif value == 69 then
    baseAddress = results[1].address + 1352
  elseif value == 70 then
    baseAddress = results[1].address + 1432
  elseif value == 71 then
    baseAddress = results[1].address + 1512

  elseif value == 72 then
    baseAddress = results[1].address + 1592
  elseif value == 73 then
    baseAddress = results[1].address + 1672
  elseif value == 74 then
    baseAddress = results[1].address + 1752
  elseif value == 75 then
    baseAddress = results[1].address + 1912
  elseif value == 76 then
    baseAddress = results[1].address + 1992
  elseif value == 77 then
    baseAddress = results[1].address + 2072
  elseif value == 78 then
    baseAddress = results[1].address + 2152
  elseif value == 79 then
    baseAddress = results[1].address + 2232
  elseif value == 80 then
    baseAddress = results[1].address + 2312
  elseif value == 81 then
    baseAddress = results[1].address + 2392
  elseif value == 82 then
    baseAddress = results[1].address + 2472
  elseif value == 83 then
    baseAddress = results[1].address + 2552
  elseif value == 84 then
    baseAddress = results[1].address + 2632
  elseif value == 85 then
    baseAddress = results[1].address + 2712
  end

local copiedValues = {}

for i = 0, 5 do
    table.insert(copiedValues, {
        address = baseAddress + (i * 4),
        flags = gg.TYPE_DWORD
    })
end

copiedValues = gg.getValues(copiedValues) -- Mengambil nilai yang disalin

gg.clearResults()
gg.searchNumber("30;1599361808", gg.TYPE_DWORD)
gg.refineNumber("30", gg.TYPE_DWORD)

local refineResults = gg.getResults(1)
if #refineResults == 0 then
    gg.alert(lng("Erro: Valores insuficientes na lista!", "Error: Insufficient values in list!", "Error: ¡Valores insuficientes en la lista!", "Kesalahan: Nilai dalam daftar tidak mencukupi!"))
    os.exit()
end

-- Offset ke 0x48
local targetAddress = refineResults[1].address - 0x48

-- Menyalin nilai yang disalin sebelumnya ke alamat ini
local newValues = {}
for i, value in ipairs(copiedValues) do
    table.insert(newValues, {
        address = targetAddress + ((i - 1) * 4),
        value = value.value,
        flags = gg.TYPE_DWORD
    })
end

table.insert(newValues, {
    address = targetAddress + (6 * 4),
    value = 0,
    flags = gg.TYPE_DWORD
})

table.insert(newValues, {
    address = targetAddress + (7 * 4),
    value = 1,
    flags = gg.TYPE_DWORD
})

gg.setValues(newValues)

end


---- ILHAS HACK
function hack1() 
  gg.toast(lng("Carregando...", "Loading...", "Cargando...", "Memuat..."))
  gg.processResume()
  gg.clearResults()
  gg.setVisible(false)
  gg.searchNumber("0", gg.TYPE_FLOAT)
  gg.alert(lng('Envie um navio pra Ilha Dos Frutos e abra o gameguardian', 'Send a ship to Island of Fruits and open gameguardian', 'Envía un barco a la Isla de las Frutas y abre GameGuardian', 'Kirim kapal ke Pulau Buah dan buka GameGuardian'))
  wait_for_action()
  gg.processResume()
  gg.setVisible(false)
  gg.refineNumber("14400", gg.TYPE_FLOAT)
  gg.getResults(30)
  setf(-4, -1)
  gg.clearResults()
end

---- FORJA HACK
function hack2()
    gg.toast(lng("Carregando...", "Loading...", "Cargando...", "Memuat..."))
    gg.processResume()
    gg.clearResults()
    gg.searchNumber("3600;7200;10800;14400", gg.TYPE_FLOAT)
    gg.refineNumber("3600", gg.TYPE_FLOAT)
    gg.getResults(30)
    gg.editAll('1', gg.TYPE_FLOAT)
    setd(16, 0)
    setd(24, 0)
    setd(32, 0)
    setf(80, 1)
    setd(96, 0)
    setd(104, 0)
    setd(112, 0)
    setf(160, 1)
    setd(176, 0)
    setd(184, 0)
    setd(192, 0)
    setf(240, 1)
    setd(256, 0)
    setd(264, 0)
    setd(272, 0)
    gg.clearResults()
end

---- HELI MONEY HACK
function hack11() 
  gg.toast(lng("Carregando...", "Loading...", "Cargando...", "Memuat..."))
  gg.processResume()
  gg.clearResults()
  gg.setVisible(false)
  gg.searchNumber("1885433110;1852403807", gg.TYPE_DWORD)
  gg.refineNumber("1885433110", gg.TYPE_DWORD)

  while true do
    xmoney = gg.prompt({lng("Quantidade de notas? [0; 18000]", "Amount of cash? [0; 18000]", "¿Cantidad de efectivo? [0; 18000]", "Jumlah uang tunai? [0; 18000]"),lng("Quantidade de dinheiro? [1; 5000000]", "Amount of money? [1; 5000000]", "¿Cantidad de dinero? [1; 5000000]", "Jumlah uang? [1; 5000000]")},{0,1},{"number","number"})
    -- Se o usuário cancelar, volta para o MENU()
    if not xmoney then
      gg.clearResults()
      MENU()
      return
    end
    -- Converte para número
    xmoney[1] = tonumber(xmoney[1])
    xmoney[2] = tonumber(xmoney[2])
    -- Valida os valores inseridos
    if xmoney[1] and xmoney[2] and xmoney[1] >= 0 and xmoney[1] <= 20000 and xmoney[2] >= 1 and xmoney[2] <= 566000000 then
      break -- Sai do loop se os valores forem válidos
    end
  end
  -- Define os valores após validação
  setd(-212, xmoney[1])
  setd(-216, 0)
  setd(-220, xmoney[2])
  setd(-224, 0)
  gg.clearResults()
end

---- HELI AUTO HACK
function hack12() 
  gg.alert(lng("Confira se os pedidos no seu heli estão apagados e abra o gameguardian novamente!", "Check if the orders on your heli are deleted and open GameGuardian again!", "¡Comprueba si se han eliminado las órdenes en tu helicóptero y abre GameGuardian de nuevo!", "Periksa apakah pesanan di helikopter Anda telah dihapus dan buka GameGuardian lagi!"))
  wait_for_action()
  gg.processResume()
  gg.clearResults()
  gg.setVisible(false)
  gg.searchNumber("1;1;16842752;0;1045220557;1053609165;100", gg.TYPE_DWORD)
  gg.refineNumber("16842752", gg.TYPE_DWORD)
  gg.getResults(30)
  setd(-8, 0)
  setd(-4, 0)
  setd(0, 0)
  setd(4, 0)
  setd(8, 0)
  setd(12, 0)
  setd(16, 0)
  gg.clearResults()
end

---- MERCADO HACK
function hack13()
  if marketinf then
    gg.processResume()
    gg.clearResults()
    gg.setVisible(false)
    gg.searchNumber("3600;86400", gg.TYPE_DWORD)
    local table = gg.getResults(30)
    for i = 1, #table do
      table[i]["value"] = 0
      table[i]["freeze"] = true 
    end
    gg.addListItems(table)
    gg.setValues(table)
    marketinf = false
  end

  gg.processResume()
  gg.clearResults()
  gg.setVisible(false)
  gg.alert(lng("Escolha um produto no mercado, insira a quantidade do último e abra o GameGuardian novamente!", "Choose a product in the market, enter the quantity of the last one, and open GameGuardian again!", "¡Elige un producto en el mercado, ingresa la cantidad del último y abre GameGuardian nuevamente!", "Pilih produk di pasar, masukkan jumlah dari yang terakhir, lalu buka GameGuardian lagi!"))
  wait_for_action()
  gg.processResume()
  gg.clearResults()
  gg.setVisible(false)
  
  inputs = gg.prompt({lng("Quantidade Do Último Item:", "Quantity Of The Last Item:", "Cantidad del último producto:", "Jumlah Item Terakhir:")})
  local qtditem = inputs[1].."X4"
  gg.searchNumber(qtditem,gg.TYPE_DWORD)
  
  while gg.getResultsCount() > 2 do
    gg.processResume()
    gg.setVisible(false)
    gg.alert(
      lng("Selecione outro item!", "Select another item!", "¡Seleccione otro producto!", "Pilih item lain!")
    )
    wait_for_action()
    gg.processResume()
    gg.setVisible(false)

    inputs2 = gg.prompt({[1] = lng("Nova quantidade do último item:", "New quantity of the last item:", "Nueva cantidad del último producto:", "Jumlah baru dari item terakhir:")}, {[1] = "0"}, {[1] = "text"})
    local qtditem2 = inputs2[1].."X4"
    gg.refineNumber(qtditem2, gg.TYPE_DWORD)
  end

  if gg.getResultsCount() <= 2 then
    
    int2 = gg.prompt({lng("Quantidade? [50; 500]", "Amount? [50; 500]", "Cantidad? [50; 500]", "Jumlah? [50; 500]")},{1},{"number"})
    int2[1] = tonumber(int2[1])

    seth(-4, 0)
    seth(0, int2[1])
    seth(4, 0)
    seth(8, 1)
    gg.toast(lng("Sucesso...", "Success...", "Éxito...", "Berhasil..."))
    marketnext = true

    local firstTimeMessage = true  -- Variável para controlar a exibição da mensagem inicial

    while marketnext do
      gg.processResume()
      gg.setVisible(false)

      -- Exibe a mensagem apenas na primeira vez
      if firstTimeMessage then
        gg.alert(lng("Pegue o item, escolha outro produto e abra o GameGuardian!", "Pick up the item, choose another product, and open GameGuardian!", "¡Recoge el producto, elige otro producto y abre GameGuardian!", "Ambil itemnya, pilih produk lain, lalu buka GameGuardian!"))
        firstTimeMessage = false  -- Marca como já exibida
      end

      wait_for_action()
      gg.processResume()
      gg.setVisible(false)

      local choice = gg.alert(
        lng("Aperte no botão para continuar hackeando os itens ou para parar", "Press the button to continue hacking the items or to stop", "Presiona el botón para continuar hackeando los elementos o para detenerlos", "Tekan tombol untuk melanjutkan meretas item atau untuk berhenti"),
        lng("Parar", "Stop", "Acabar", "Berhenti"),
        lng("Continuar", "Again", "Continuar", "Lanjutkan")
      )

      if choice == 1 then
        MENU()
        marketnext = false
        gg.clearResults()
      elseif choice == 2 then
        seth(-4, 0)
        seth(0, int2[1])
        seth(4, 0)
        seth(8, 1)
        gg.toast(lng("Sucesso...", "Success...", "Éxito...", "Berhasil..."))
      end
    end
  end
end

---- ANIMAIS HACK
function hack14()
  gg.toast(lng("Carregando...", "Loading...", "Cargando...", "Memuat..."))
  gg.processResume()
  gg.clearResults()
  gg.searchNumber("1200;3600", gg.TYPE_FLOAT)
  gg.getResults(4)
  gg.editAll('1', gg.TYPE_FLOAT)
  gg.clearResults()
  gg.searchNumber("14400;25200", gg.TYPE_FLOAT)
  gg.getResults(10)
  gg.editAll('1', gg.TYPE_FLOAT)
  gg.clearResults()
  gg.searchNumber("21600", gg.TYPE_FLOAT)
  gg.getResults(10)
  gg.editAll('1', gg.TYPE_FLOAT)
  gg.clearResults()
end

---- GOLDPASS HACK
function hack15()
  gg.toast(lng("Carregando...", "Loading...", "Cargando...", "Memuat..."))
  gg.processResume()
  gg.clearResults()
  gg.searchNumber("1819042080;1986622325;842019429;53;1852990764;3486256;49", gg.TYPE_DWORD )
  gg.refineNumber("53", gg.TYPE_DWORD )
  setd2(160, 0)
  setd2(164, 7000)
  setd2(176, 1)
  gg.clearResults()
end

---- CONGELAR POPULAÇÃO HACK
function hack25()
  gg.toast(lng("Carregando...", "Loading...", "Cargando...", "Memuat..."))
  gg.processResume()
  gg.clearResults()
  gg.setVisible(false)
  gg.alert(
    lng("Verifique a população necessária para desbloquear o terreno, depois abra o Gameguardian", "Check the required population to unlock the land, then open the Gameguardian", "Verifica la población necesaria para desbloquear el terreno, luego abre el Gameguardian")
  )
  wait_for_action()
  gg.processResume()
  gg.setVisible(false)
  -- Primeiro prompt
  ppls = gg.prompt({[1] = lng("Quantidade de população para desbloquear o proximo terreno?", "Amount of population to unlock the next land?", "¿Cantidad de población para desbloquear la siguiente tierra?")}, {[1] = "0"}, {[1] = "text"})
  -- Se o usuário cancelar, voltar para o MENU()
  if ppls == nil then
    MENU()  -- Supondo que MENU() seja o nome da função do menu
    return
  end
  
  local pqsa = ppls[1]..";616D5312h;704f6C6Ch;70784518h;42646E61h;6F747475h;0000006Eh"
  gg.searchNumber(pqsa, gg.TYPE_DWORD)
  gg.refineNumber(ppls[1], gg.TYPE_DWORD)
  
  if gg.getResultsCount() <= 2 then
    gg.processResume()
    gg.setVisible(false)
    local table = gg.getResults(2)
    for i = 1, #table do
      table[i]["value"] = 1
      table[i]["freeze"] = true 
    end
    gg.addListItems(table)
    gg.setValues(table)
    gg.toast(lng("Sucesso...", "Success...", "Éxito...", "Berhasil..."))
  end
  gg.clearResults()
end

---- XP TRIGO HACK
function hack16()
  gg.toast(lng("Carregando...", "Loading...", "Cargando...", "Memuat..."))
  gg.processResume()
  gg.clearResults()
  gg.setVisible(false)
  gg.searchNumber("120;300", gg.TYPE_FLOAT)
  gg.refineNumber("120", gg.TYPE_FLOAT)
  xps = gg.prompt({[1] = lng("Quantidade de xp desejada? Max: 9000", "Amount of XP desired? Max: 9000", "Cantidad de XP deseada? Máx: 9000", "Jumlah XP yang diinginkan?")}, {[1] = "0"}, {[1] = "text"})
  -- Verifica se o usuário cancelou a entrada
  if xps == nil then
    MENU()  -- Chama o menu
    return  -- Interrompe a função se o usuário cancelar
  end
  xps[1] = tonumber(xps[1])
  -- Verifica se a entrada do usuário é válida
  if xps[1] == nil then
    MENU()  -- Chama o menu
    return  -- Interrompe a função se o valor for inválido
  end
  setd(0, 0)
  setd(16, 0)
  setd(20, xps[1])
  gg.clearResults()
end

---- HACK ACADEMIA
function seth(offset, new)
  local table = gg.getResults(30)
  for i = 1, #table do
     table[i]["address"] = table[i]["address"] + offset 
     table[i]["flags"] = gg.TYPE_DWORD
     table[i]["value"] = new.."X4"
     gg.addListItems(table) 
     gg.setValues(table)
  end
end

function hack2C()
  gg.toast(lng("Carregando...", "Loading...", "Cargando...", "Memuat..."))
  gg.processResume()
  gg.clearResults()
  gg.alert(
    lng("Verifique o bônus de tempo de alguma fabrica na academia da indústria.", "Check the time bonus from a factory at the industry academy.", "Consulta la bonificación de tiempo de una fábrica en la academia de la industria.")
  )
  wait_for_action()
  gg.processResume()
  gg.setVisible(false)
  -- Primeira entrada do usuário
  input = gg.prompt({lng("Bonus Tempo","Bonus Time","Tiempo Bonificación"), lng("Navio","Ship","Isla")}, nil, {'number', 'checkbox'})
  if input == nil then
    return MENU()  -- Se o usuário cancelar, volta ao MENU()
  end
  local bonus = input[1].."X4"
  gg.searchNumber(bonus, gg.TYPE_DWORD)
  while gg.getResultsCount() > 2 do
    gg.processResume()
    gg.setVisible(false)
    gg.alert(
        lng("Evolua 1 level de bonus de tempo na fabrica e abra o gameguardian", "Level up 1 time bonus in the factory and open GameGuardian.", "Sube 1 nivel de bonificación por única vez en la fábrica y abre GameGuardian.", "Naikkan 1 level bonus waktu di pabrik dan buka GameGuardian.")
    )
    wait_for_action()
    gg.processResume()
    gg.setVisible(false)
    -- Segunda entrada do usuário
    input2 = gg.prompt({[1] = lng("Novo valor do bonus de tempo da fabrica", "New time bonus value from the factory.", "Nuevo valor de bonificación de tiempo de fábrica.", "Nilai bonus waktu baru dari pabrik.")}, {[1] = "0"}, {[1] = "text"})
    if input2 == nil then
      return MENU()  -- Se o usuário cancelar, volta ao MENU()
    end
    local bonus2 = input2[1].."X4"
    gg.refineNumber(bonus2, gg.TYPE_DWORD)
  end
  if gg.getResultsCount() <= 3 then
    gg.processResume()
    gg.setVisible(false)
    local table = gg.getResults(2)
    if input[2] == true then
      seth(0, 99)
    else
      seth(0, 100)
    end
    gg.toast(lng("Sucesso...", "Success...", "Éxito...", "Berhasil..."))
  end
  gg.clearResults()
end

---- HACK PIRATA EVENTO
function hackzz()
  gg.toast(lng("Carregando...", "Loading...", "Cargando...", "Memuat..."))
  gg.processResume()
  gg.clearResults()
  gg.setVisible(false)
  gg.searchNumber("1698849641;1734429984;30", gg.TYPE_DWORD)
  gg.refineNumber("30", gg.TYPE_DWORD)
  setd(-112, 1)
  setd(-116, 0)
  gg.clearResults()
end

---- HACK TEMPO TRAIN
function hack22(isFree)
  gg.clearResults()
  r = gg.prompt({lng('⏱️ HORAS [0;5]', '⏱️ HOURS [0;5]', '⏱️ HORAS [0;5]', '⏱️ JAM [0;5]'),lng('⏱️ MINUTOS [0;55]', '⏱️ MINUTES [0;55]', '⏱️ MINUTOS [0;55]', '⏱️ MENIT [0;55]')},{0,0},{'number','number'})
  h = {'0','1','2','3','4','5'}
  m = {'0','15','30','45','50','55'}
  
  if r == nil then
    if isFree then
      MENUFREE()
    else
      MENU()
    end
  else

    if r[1] == '1' then rp = h[1] end
    if r[1] == '2' then rp = h[2] end
    if r[1] == '3' then rp = h[3] end
    if r[1] == '4' then rp = h[4] end
    if r[1] == '5' then rp = h[5] end
    if r[1] == '6' then rp = h[6] end
  
    if r[2] == '1' then rp = m[1] end
    if r[2] == '2' then rp = m[2] end
    if r[2] == '3' then rp = m[3] end
    if r[2] == '4' then rp = m[4] end
    if r[2] == '5' then rp = m[5] end
    if r[2] == '6' then rp = m[6] end

    local horas = r[1] * 3600
    local minutos = r[2] * 60
    local tempo = horas + minutos
    gg.searchNumber(tempo,gg.TYPE_FLOAT)
    local table = gg.getResults(999)
    for i = 1, #table do
      table[i]["value"] = 1
      table[i]["freeze"] = true 
    end
    
    gg.addListItems(table)
    gg.setValues(table)
  end
end

---- HACK ITENS GOLDPASS
function hack(variacao)
  gg.toast(lng("Carregando...", "Loading...", "Cargando...", "Memuat..."))
  gg.processResume()
  gg.clearResults()
  gg.setVisible(false)

  gg.searchNumber("1701996056;1651327333;99;5;30", gg.TYPE_DWORD)
  gg.refineNumber("30", gg.TYPE_DWORD)

  -- Solicita quantidade apenas se necessário
  local int1 = nil
  if variacao == "g" or variacao == "h" or variacao == "i" or
     variacao == "j" or variacao == "j2" or variacao == "k" or variacao == "k2" or 
     variacao == "l" or variacao == "l2" or variacao == "l3" or variacao == "l4" or variacao == "l5" or variacao == "l6" or 
     variacao == "l7" or variacao == "n" or variacao == "m" or variacao == "o" or variacao == "lg1" or 
     variacao == "lg2" or variacao == "lg3" or variacao == "lg4" or variacao == "lg5" or variacao == "lg6" or
     variacao == "lg7" or variacao == "lg8" or variacao == "lm2" or variacao == "lm02" or variacao == "lm002" or variacao == "lm3" or variacao == "lm4" or
     variacao == "lm5" or variacao == "lm6" or variacao == "ld2" or variacao == "p1" or variacao == "p2" or variacao == "p3" or variacao == "p4" or
     variacao == "p5" or variacao == "p55" or variacao == "p6" or variacao == "p7" or variacao == "p8" or variacao == "p9" or variacao == "p10" or variacao == "p11" then
    while true do
      int1 = gg.prompt({lng("Quantidade? [0; 999]", "Amount? [0; 999]", "Cantidad? [0; 999]", "Jumlah? [0; 999]")}, {1}, {"number"})
      -- Se o usuário cancelar, volta para o MENU()
      if not int1 then
        gg.clearResults()
        MENU()
        return
      end
      -- Converte para número e verifica se está dentro do intervalo válido
      int1[1] = tonumber(int1[1])
      if int1[1] and int1[1] >= 0 and int1[1] <= 999 then
        break -- Sai do loop se o valor for válido
      end
    end
  end

  if variacao == "a" then
    setd(-48, 0)
    setd(-44, 500)
    setd(-52, "0074726Fh")
    setd(-56, "70726941h")
    setd(-60, "6E696172h")
    setd(-64, "5464616Fh")
    setd(-68, "4C6E6F70h")
    setd(-72, "756F432Ch")
  elseif variacao == "b" then
    setd(-48, 0)
    setd(-44, 500)
    setd(-52, "0")
    setd(-56, "0")
    setd(-60, "00006E6Fh")
    setd(-64, "69736E61h")
    setd(-68, "70784565h")
    setd(-72, "6572661Ah")
  elseif variacao == "c" then
    setd(-48, 0)
    setd(-44, 500)
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00000063h")
    setd(-64, "6E497261h")
    setd(-68, "626D4165h")
    setd(-72, "65726618h")
  elseif variacao == "d" then
    setd(-48, 0)
    setd(-44, 500)
    setd(-52, "00000079h")
    setd(-56, "726F7463h")
    setd(-60, "61466564h")
    setd(-64, "61726770h")
    setd(-68, "556E6F70h")
    setd(-72, "756F4328h")
  elseif variacao == "e" then
    setd(-48, 0)
    setd(-44, 500)
    setd(-52, "1970225956")
    setd(-56, "7235937")
    setd(-60, "1918133604")
    setd(-64, "1634887536")
    setd(-68, "1433300848")
    setd(-72, "1970225956")
  elseif variacao == "f" then
    setd(-48, 0)
    setd(-44, 500)
    setd(-52, "0")
    setd(-56, "1684955500")
    setd(-60, "1934189924")
    setd(-64, "1634887536")
    setd(-68, "1433300848")
    setd(-72, "1970225958")
  elseif variacao == "mm" then
    setd(-48, 0)
    setd(-44, 500)
    setd(-52, "00000000h")
    setd(-56, "00000072h")
    setd(-60, "656C6165h")
    setd(-64, "44657269h")
    setd(-68, "486E6F70h")
    setd(-72, "756F4320h")
  ---- HACK MINA ITENS
  elseif variacao == "g" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00000000h")
    setd(-64, "00000000h")
    setd(-68, "00000000h")
    setd(-72, "00336D04h")
  elseif variacao == "h" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00000000h")
    setd(-64, "00000000h")
    setd(-68, "00000000h")
    setd(-72, "00326D04h")
  elseif variacao == "i" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00000000h")
    setd(-64, "00000000h")
    setd(-68, "00000000h")
    setd(-72, "00316D04h")
  ---- HACK CONSTRUÇÃO ITENS
  elseif variacao == "j" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000079h")
    setd(-56, "1BFDEA58h")
    setd(-60, "00000000h")
    setd(-64, "00000000h")
    setd(-68, "00007373h")
    setd(-72, "616C470Ah")
 elseif variacao == "j2" then 
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00006500h")
    setd(-56, "6C616972h")
    setd(-60, "65006B63h")
    setd(-64, "00720077h")
    setd(-68, "61737265h")
    setd(-72, "776F7010h")
  elseif variacao == "k" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000078h")
    setd(-56, "722A8208h")
    setd(-60, "00000079h")
    setd(-64, "38DF4A98h")
    setd(-68, "00006B63h")
    setd(-72, "6972420Ah")
  elseif variacao == "k2" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00006500h")
    setd(-56, "6C616972h")
    setd(-60, "65006B63h")
    setd(-64, "0072656Dh")
    setd(-68, "6D61686Bh")
    setd(-72, "63616A14h")
  elseif variacao == "l" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000079h")
    setd(-56, "23CA6A58h")
    setd(-60, "00000000h")
    setd(-64, "00000000h")
    setd(-68, "00006174h")
    setd(-72, "696C500Ah")
  elseif variacao == "l2" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00006500h")
    setd(-56, "6C616972h")
    setd(-60, "65006B63h")
    setd(-64, "00720077h")
    setd(-68, "61006C6Ch")
    setd(-72, "6972640Ah")
  elseif variacao == "l3" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00000000h")
    setd(-64, "00000000h")
    setd(-68, "74614D6Ch")
    setd(-72, "69616E0Eh")
  elseif variacao == "l4" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "801032E8h")
    setd(-56, "1F5956E2h")
    setd(-60, "00000002h")
    setd(-64, "72007461h")
    setd(-68, "4D72656Dh")
    setd(-72, "6D616812h")
  elseif variacao == "l5" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00000000h")
    setd(-64, "74614D64h")
    setd(-68, "6552746Eh")
    setd(-72, "69617016h")
  elseif variacao == "l6" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00000000h")
    setd(-64, "00000000h")
    setd(-68, "00000000h")
    setd(-72, "65786106h")
  elseif variacao == "l7" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00000000h")
    setd(-64, "00000000h")
    setd(-68, "0000006Bh")
    setd(-72, "63697008h")
    ---- HACK GEMAS ITENS
  elseif variacao == "n" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00000000h")
    setd(-64, "00000000h")
    setd(-68, "00000031h")
    setd(-72, "6D656708h")
  elseif variacao == "m" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00000000h")
    setd(-64, "00000000h")
    setd(-68, "00000032h")
    setd(-72, "6D656708h")
  elseif variacao == "o" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00000000h")
    setd(-64, "00000000h")
    setd(-68, "00000033h")
    setd(-72, "6D656708h")
  ---- FICHAS LOJA REGATA
  elseif variacao == "p" then
    setd(-48, 0)
    setd(-44, 2000)
    setd(-52, "0")
    setd(-56, "0")
    setd(-60, "0")
    setd(-64, "00687361h")
    setd(-68, "43617461h")
    setd(-72, "67655214h")
  ---- FICHAS LOJA REGATA
  elseif variacao == "q" then
    setd(-48, 0)
    setd(-44, 500)
    setd(-52, "0")
    setd(-56, "0")
    setd(-60, "0")
    setd(-64, "00687361h")
    setd(-68, "43617461h")
    setd(-72, "67655214h")
  ---- PLANTAÇÕES HACK
  elseif variacao == "x" then
    setd(-48, 0)
    setd(-44, 100)
    setd(-52, 7631717)
    setd(-56, 1987207496)
    setd(-60, 1884644453)
    setd(-64, 1701860212)
    setd(-68, 1936682818)
    setd(-72, 1599099692)
  ---- PLANTAÇÕES HACK
  elseif variacao == "z" then
    setd(-48, 0)
    setd(-44, 1)
    setd(-52, "0000313Ah")
    setd(-56, "522C353Ah")
    setd(-60, "552C3531h")
    setd(-64, "3A432C30h")
    setd(-68, "333A4E6Bh")
    setd(-72, "6365642Ah")
  ---- LINGOTES HACK
elseif variacao == "lg1" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000072h")
    setd(-56, "65746E75h")
    setd(-60, "6F436E6Fh")
    setd(-64, "696C6C75h")
    setd(-68, "42657A6Eh")
    setd(-72, "6F724228h")
  elseif variacao == "lg2" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000072h")
    setd(-56, "65746E75h")
    setd(-60, "6F436E6Fh")
    setd(-64, "696C6C75h")
    setd(-68, "42726576h")
    setd(-72, "6C695328h")
  elseif variacao == "lg3" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "00726574h")
    setd(-60, "6E756F43h")
    setd(-64, "6E6F696Ch")
    setd(-68, "6C754264h")
    setd(-72, "6C6F4724h")
  elseif variacao == "lg4" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "7497076")
    setd(-56, "1853189955")
    setd(-60, "1852795244")
    setd(-64, "1819624045")
    setd(-68, "1970170228")
    setd(-72, "1634488364")
  elseif variacao == "lg5" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00000000h")
    setd(-64, "00000000h")
    setd(-68, "00000000h")
    setd(-72, "00316F04h")
  elseif variacao == "lg6" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00000000h")
    setd(-64, "00000000h")
    setd(-68, "00000000h")
    setd(-72, "00336F04h")
  elseif variacao == "lg7" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00000000h")
    setd(-64, "00000000h")
    setd(-68, "00000000h")
    setd(-72, "00326F04h")
  elseif variacao == "lg8" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00000000h")
    setd(-64, "00000000h")
    setd(-68, "00000000h")
    setd(-72, "00346F04h")
    ---- BOOSTER LAB HACK
  elseif variacao == "lb1" then
    setd(-48, 0)
    setd(-44, 80)
    setd(-52, "00000000h")
    setd(-56, "00007370h")
    setd(-60, "69685370h")
    setd(-64, "55646565h")
    setd(-68, "70537473h")
    setd(-72, "6F6F4222h")
  elseif variacao == "lb2" then
    setd(-48, 0)
    setd(-44, 80)
    setd(-52, "00000000h")
    setd(-56, "00736E69h")
    setd(-60, "61725470h")
    setd(-64, "55646565h")
    setd(-68, "70537473h")
    setd(-72, "6F6F4224h")
  elseif variacao == "lb3" then
    setd(-48, 0)
    setd(-44, 80)
    setd(-52, "0")
    setd(-56, "28007972h")
    setd(-60, "65746C65h")
    setd(-64, "6D53656Dh")
    setd(-68, "69547473h")
    setd(-72, "6F6F4222h")
  elseif variacao == "lb4" then
    setd(-48, 0)
    setd(-44, 80)
    setd(-52, "0")
    setd(-56, "0")
    setd(-60, "74656B72h")
    setd(-64, "614D656Dh")
    setd(-68, "69547473h")
    setd(-72, "6F6F421Eh")
  elseif variacao == "lb5" then
    setd(-48, 0)
    setd(-44, 80)
    setd(-52, "0")
    setd(-56, "283D0079h")
    setd(-60, "726F7463h")
    setd(-64, "6146656Dh")
    setd(-68, "69547473h")
    setd(-72, "6F6F4220h")
  elseif variacao == "lb6" then
    setd(-48, 0)
    setd(-44, 80)
    setd(-52, "0")
    setd(-56, "28007265h")
    setd(-60, "64724F70h")
    setd(-64, "55646565h")
    setd(-68, "70537473h")
    setd(-72, "6F6F4222h")
  elseif variacao == "lb7" then
    setd(-48, 0)
    setd(-44, 80)
    setd(-52, "0")
    setd(-56, "74736576h")
    setd(-60, "72614870h")
    setd(-64, "55646565h")
    setd(-68, "70537473h")
    setd(-72, "6F6F4226h")
  elseif variacao == "lb8" then
    setd(-48, 0)
    setd(-44, 80)
    setd(-52, "0")
    setd(-56, "74736576h")
    setd(-60, "72614874h")
    setd(-64, "6375646Fh")
    setd(-68, "72507473h")
    setd(-72, "6F6F4226h")
  elseif variacao == "lb9" then
    setd(-48, 0)
    setd(-44, 80)
    setd(-52, "0")
    setd(-56, "109")
    setd(-60, "1918977652")
    setd(-64, "1668637807")
    setd(-68, "1917875315")
    setd(-72, "1869562400")
elseif variacao == "lb10" then
    setd(-48, 0)
    setd(-44, 80)
    setd(-52, "0")
    setd(-56, "0")
    setd(-60, "72656472h")
    setd(-64, "4F79656Eh")
    setd(-68, "6F4D7473h")
    setd(-72, "6F6F421Eh")
  elseif variacao == "lb11" then
    setd(-48, 0)
    setd(-44, 80)
    setd(-52, "0")
    setd(-56, "0")
    setd(-60, "00657461h")
    setd(-64, "6E6F4478h")
    setd(-68, "614D7473h")
    setd(-72, "6F6F421Ch")
  elseif variacao == "lb12" then
    setd(-48, 0)
    setd(-44, 80)
    setd(-52, "0")
    setd(-56, "0")
    setd(-60, "006F6F5Ah")
    setd(-64, "73747261h")
    setd(-68, "65487473h")
    setd(-72, "6F6F421Ch")
  elseif variacao == "lb13" then
    setd(-48, 0)
    setd(-44, 80)
    setd(-52, "0")
    setd(-56, "0079726Fh")
    setd(-60, "74636146h")
    setd(-64, "656C6275h")
    setd(-68, "6F447473h")
    setd(-72, "6F6F4224h")
  elseif variacao == "lb14" then
    setd(-48, 0)
    setd(-44, 80)
    setd(-52, "0")
    setd(-56, "2800736Eh")
    setd(-60, "696F4374h")
    setd(-64, "726F7072h")
    setd(-68, "69417473h")
    setd(-72, "6F6F4222h")
  elseif variacao == "lb15" then
    setd(-48, 0)
    setd(-44, 80)
    setd(-52, "00000074h")
    setd(-56, "73657571h")
    setd(-60, "6552706Ch")
    setd(-64, "65486E61h")
    setd(-68, "6C437473h")
    setd(-72, "6F6F4228h")
  elseif variacao == "lb16" then
    setd(-48, 0)
    setd(-44, 80)
    setd(-52, "73646E61h")
    setd(-56, "6C734979h")
    setd(-60, "74696C69h")
    setd(-64, "6261626Fh")
    setd(-68, "72507473h")
    setd(-72, "6F6F422Eh")
  elseif variacao == "lb17" then
    setd(-48, 0)
    setd(-44, 80)
    setd(-52, "73646E61h")
    setd(-56, "6C734979h")
    setd(-60, "74696C69h")
    setd(-64, "6261626Fh")
    setd(-68, "72507473h")
    setd(-72, "6F6F422Eh")
    ---- BOOSTER MINIGAME HACK
  elseif variacao == "lm1" then
    setd(-48, 0)
    setd(-44, 5)
    setd(-52, "0")
    setd(-56, "1701669204")
    setd(-60, "1718511967")
    setd(-64, "1936029289")
    setd(-68, "1278437475")
    setd(-72, "1952533798")
  elseif variacao == "lm2" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "0")
    setd(-56, "0")
    setd(-60, "27756")
    setd(-64, "1631745903")
    setd(-68, "1651403105")
    setd(-72, "1379101978")
  elseif variacao == "lm02" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "0")
    setd(-56, "0")
    setd(-60, "0")
    setd(-64, "0")
    setd(-68, "00656E69h")
    setd(-72, "4C336D0Ch")
  elseif variacao == "lm002" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "0")
    setd(-56, "0")
    setd(-60, "0")
    setd(-64, "0")
    setd(-68, "6450543")
    setd(-72, "1110666508")
  elseif variacao == "lm3" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "0")
    setd(-56, "0")
    setd(-60, "7497069")
    setd(-64, "1835100261")
    setd(-68, "1734632812")
    setd(-72, "1395879196")
  elseif variacao == "lm4" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "0")
    setd(-56, "0")
    setd(-60, "0")
    setd(-64, "114")
    setd(-68, "1701670241")
    setd(-72, "1211329808")
  elseif variacao == "lm5" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "0")
    setd(-56, "0")
    setd(-60, "0")
    setd(-64, "0")
    setd(-68, "1702260588")
    setd(-72, "1194552590")
  elseif variacao == "lm6" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "0")
    setd(-56, "121")
    setd(-60, "1735550318")
    setd(-64, "1164865385")
    setd(-68, "1953064037")
    setd(-72, "1886938400")
  elseif variacao == "lm7" then
    setd(-48, 0)
    setd(-44, 2592000)
    setd(-52, "0032586Ch")
    setd(-56, "6C416472h")
    setd(-60, "61776552h")
    setd(-64, "79746974h")
    setd(-68, "6E456465h")
    setd(-72, "6D69542Ch")
---- VANTAGEM HACK
  elseif variacao == "lv1" then
    setd(-48, 0)
    setd(-44, 5)
    setd(-52, "0")
    setd(-56, "29556")
    setd(-60, "1632464489")
    setd(-64, "1634882676")
    setd(-68, "1936682818")
    setd(-72, "1599099682")
  elseif variacao == "lv2" then
    setd(-48, 0)
    setd(-44, 1)
    setd(-52, "0")
    setd(-56, "00006D75h")
    setd(-60, "696D6572h")
    setd(-64, "50746F6Ch")
    setd(-68, "5362614Ch")
    setd(-72, "5F505322h")
  elseif variacao == "lv3" then
    setd(-48, 0)
    setd(-44, 50)
    setd(-52, "0")
    setd(-56, "7564905")
    setd(-60, "1866691173")
    setd(-64, "1685213044")
    setd(-68, "1936682818")
    setd(-72, "1599099684")
  elseif variacao == "lv4" then
    setd(-48, 0)
    setd(-44, 1)
    setd(-52, "0")
    setd(-56, "-1308229523")
    setd(-60, "1969843557")
    setd(-64, "1917875301")
    setd(-68, "1802658125")
    setd(-72, "1599099680")
  elseif variacao == "lv5" then
    setd(-48, 0)
    setd(-44, 1)
    setd(-52, "0")
    setd(-56, "-1308594827")
    setd(-60, "1768777074")
    setd(-64, "1349675329")
    setd(-68, "1684107084")
    setd(-72, "1599099682")
  elseif variacao == "lv6" then
    setd(-48, 0)
    setd(-44, 100)
    setd(-52, "0")
    setd(-56, "7498049")
    setd(-60, "1884644453")
    setd(-64, "1701860212")
    setd(-68, "1936682818")
    setd(-72, "1599099684")
  elseif variacao == "lv9" then
    setd(-48, 0)
    setd(-44, 50)
    setd(-52, "3299436")
    setd(-56, "1816224882")
    setd(-60, "1635214674")
    setd(-64, "2037672308")
    setd(-68, "1850041445")
    setd(-72, "1835619372")
  elseif variacao == "lv10" then
    setd(-48, 0)
    setd(-44, 50)
    setd(-52, "0")
    setd(-56, "0")
    setd(-60, "0")
    setd(-64, "0")
    setd(-68, "7497078")
    setd(-72, "1869374220")
  elseif variacao == "lv11" then
    setd(-48, 0)
    setd(-44, 50)
    setd(-52, "32767")
    setd(-56, "915593664")
    setd(-60, "114")
    setd(-64, "1701669204")
    setd(-68, "1885956947")
    setd(-72, "1599099672")
  ---- DINHEIRO DECORAÇÃO
  elseif variacao == "ld1" then
    setd(-48, 0)
    setd(-44, 1)
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00007265h")
    setd(-64, "74697277h")
    setd(-68, "5F657574h")
    setd(-72, "6174731Ah")
  elseif variacao == "ld2" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00000000h")
    setd(-64, "00000000h")
    setd(-68, "00000068h")
    setd(-72, "73616308h")
  elseif variacao == "p1" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00000072h")
    setd(-64, "65746E75h")
    setd(-68, "6F436E6Fh")
    setd(-72, "63616218h")
  elseif variacao == "p2" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00000000h")
    setd(-64, "00726574h")
    setd(-68, "6E756F43h")
    setd(-72, "67676514h")
  elseif variacao == "p3" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "07930072h")
    setd(-60, "65746E75h")
    setd(-64, "6F43626Dh")
    setd(-68, "6F637965h")
    setd(-72, "6E6F6820h")
  elseif variacao == "p4" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00000000h")
    setd(-64, "7265746Eh")
    setd(-68, "756F436Bh")
    setd(-72, "6C696D16h")
  elseif variacao == "p5" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00000000h")
    setd(-56, "00000000h")
    setd(-60, "00000000h")
    setd(-64, "7265746Eh")
    setd(-68, "756F436Ch")
    setd(-72, "6F6F7716h")
  elseif variacao == "p55" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00007638h")
    setd(-56, "63BEE700h")
    setd(-60, "7265746Eh")
    setd(-64, "756F436Dh")
    setd(-68, "6F6F7268h")
    setd(-72, "73756D1Eh")
  elseif variacao == "p6" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00007638h")
    setd(-56, "64BD475Ah")
    setd(-60, "00726574h")
    setd(-64, "6E756F43h")
    setd(-68, "64656566h")
    setd(-72, "776F631Ch")
  elseif variacao == "p7" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00007638h")
    setd(-56, "00726574h")
    setd(-60, "6E756F43h")
    setd(-64, "64656566h")
    setd(-68, "6E656B63h")
    setd(-72, "69686324h")
  elseif variacao == "p8" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00007638h")
    setd(-56, "64BD0072h")
    setd(-60, "65746E75h")
    setd(-64, "6F436465h")
    setd(-68, "65667065h")
    setd(-72, "65687320h")
  elseif variacao == "p9" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00007638h")
    setd(-56, "630A775Ah")
    setd(-60, "00726574h")
    setd(-64, "6E756F43h")
    setd(-68, "64656566h")
    setd(-72, "6565621Ch")
  elseif variacao == "p10" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00007638h")
    setd(-56, "630A775Ah")
    setd(-60, "00726574h")
    setd(-64, "6E756F43h")
    setd(-68, "64656566h")
    setd(-72, "6769701Ch")
  elseif variacao == "p11" then
    setd(-48, 0)
    setd(-44, int1[1])
    setd(-52, "00007600h")
    setd(-56, "7265746Eh")
    setd(-60, "756F4364h")
    setd(-64, "6565666Dh")
    setd(-68, "6F6F7268h")
    setd(-72, "73756D26h")
  end
  gg.clearResults()
end

---- DINAMITE EXPENDIÇÃO
function hackevd()
  gg.toast("Carregando...")
  gg.processResume()
  gg.clearResults()
  gg.setVisible(false)
  gg.searchNumber("40;1;72;2;160;5", gg.TYPE_DWORD)
  gg.refineNumber("160", gg.TYPE_DWORD)
  setd(0, 0)
  setd(4, 99)
end

---- FUNÇÃO DE SKINS
function hack_skins(values)
  gg.toast("Carregando...")
  gg.processResume()
  gg.clearResults()
  gg.setVisible(false)

  gg.searchNumber("1701996056;1651327333;99;5;30", gg.TYPE_DWORD)
  gg.refineNumber("30", gg.TYPE_DWORD)
  setd(-48, 0)
  setd(-44, 1)
  for i = 1, #values do
      setd(-48 - (i * 4), values[i])
  end
  gg.clearResults()
end

---- STICKERS ADESIVOS HACK
function hackss(choice)
  local skins = {}
  
  -- Define the skins in reverse order
  if choice == 0 then
    skins = {"00000000h", "00000000h", "00000000h", "2E383574h", "735F696Ah", "6F6D6514h"} -- Congratulations
  elseif choice == 1 then
    skins = {"00000000h", "00000000h", "00000000h", "2E373574h", "735F696Ah", "6F6D6514h"} -- Archer Sheep
  elseif choice == 2 then
    skins = {"00000000h", "00000000h", "00000000h", "2E363574h", "735F696Ah", "6F6D6514h"} -- Vampire Cow
  elseif choice == 3 then
    skins = {"00000000h", "00000000h", "00000000h", "2E353574h", "735F696Ah", "6F6D6514h"} -- Cook Cow
  elseif choice == 4 then
    skins = {"00000000h", "00000000h", "00000000h", "2E333574h", "735F696Ah", "6F6D6514h"} -- Detective Stories
  elseif choice == 5 then
    skins = {"00000000h", "00000000h", "00000000h", "2E303174h", "735F696Ah", "6F6D6514h"} -- Chicken Witch
  elseif choice == 6 then
    skins = {"00000000h", "00000000h", "00000000h", "2E313174h", "735F696Ah", "6F6D6514h"} -- Bee Mummy
  elseif choice == 7 then
    skins = {"00000000h", "00000000h", "00000000h", "2E323174h", "735F696Ah", "6F6D6514h"} -- Weresheep
  elseif choice == 8 then
    skins = {"00000000h", "00000000h", "00000000h", "2E353174h", "735F696Ah", "6F6D6514h"} -- Carrot Drake
  elseif choice == 9 then
    skins = {"00000000h", "00000000h", "00000000h", "2E343174h", "735F696Ah", "6F6D6514h"} -- Farmer Pig
  elseif choice == 10 then
    skins = {"00000000h", "00000000h", "00000000h", "2E333174h", "735F696Ah", "6F6D6514h"} -- Thrifty Cow
  elseif choice == 11 then
    skins = {"00000000h", "00000000h", "00000000h", "2E373174h", "735F696Ah", "6F6D6514h"} -- Happy Sheep
  elseif choice == 12 then
    skins = {"00000000h", "00000000h", "00000000h", "2E383174h", "735F696Ah", "6F6D6514h"} -- Ice-Skating Chicken
  elseif choice == 13 then
    skins = {"00000000h", "00000000h", "00000000h", "2E323274h", "735F696Ah", "6F6D6514h"} -- Extraterrestrial Cow
  elseif choice == 14 then
    skins = {"00000000h", "00000000h", "00000000h", "2E333274h", "735F696Ah", "6F6D6514h"} -- Astronaut Piggy
  elseif choice == 15 then
    skins = {"00000000h", "00000000h", "00000000h", "2E363274h", "735F696Ah", "6F6D6514h"} -- Bee Mime
  elseif choice == 16 then
    skins = {"00000000h", "00000000h", "00000000h", "2E343274h", "735F696Ah", "6F6D6514h"} -- Chicken Chef
  elseif choice == 17 then
    skins = {"00000000h", "00000000h", "00000000h", "2E353274h", "735F696Ah", "6F6D6514h"} -- Duck Influencer
  elseif choice == 18 then
    skins = {"00000000h", "00000000h", "00000000h", "2E373274h", "735F696Ah", "6F6D6514h"} -- Musical Sheep
  elseif choice == 19 then
    skins = {"00000000h", "00000000h", "00000000h", "2E383274h", "735F696Ah", "6F6D6514h"} -- Genie Otter
  elseif choice == 20 then
    skins = {"00000000h", "00000000h", "00000000h", "2E393274h", "735F696Ah", "6F6D6514h"} -- Artistic Chicken
  elseif choice == 21 then
    skins = {"00000000h", "00000000h", "00000000h", "2E303374h", "735F696Ah", "6F6D6514h"} -- Surprise Bee
  elseif choice == 22 then
    skins = {"00000000h", "00000000h", "00000000h", "2E313374h", "735F696Ah", "6F6D6514h"} -- Rockin' Cow
  elseif choice == 23 then
    skins = {"00000000h", "00000000h", "00000000h", "2E323374h", "735F696Ah", "6F6D6514h"} -- Drummer Otter
  elseif choice == 24 then
    skins = {"00000000h", "00000000h", "00000000h", "2E343374h", "735F696Ah", "6F6D6514h"} -- Carnival of Venice
  elseif choice == 25 then
    skins = {"00000000h", "00000000h", "00000000h", "2E363374h", "735F696Ah", "6F6D6514h"} -- Protocow
  elseif choice == 26 then
    skins = {"00000000h", "00000000h", "00000000h", "2E353374h", "735F696Ah", "6F6D6514h"} -- Cavesheep
  elseif choice == 27 then
    skins = {"00000000h", "00000000h", "00000000h", "2E373374h", "735F696Ah", "6F6D6514h"} -- Seaside Vacation Chill
  elseif choice == 28 then
    skins = {"00000000h", "00000000h", "00000000h", "2E383374h", "735F696Ah", "6F6D6514h"} -- Seaside Vacation Tan
  elseif choice == 29 then
    skins = {"00000000h", "00000000h", "00000000h", "2E303474h", "735F696Ah", "6F6D6514h"} -- Bovine Film Buff
  elseif choice == 30 then
    skins = {"00000000h", "00000000h", "00000000h", "2E393374h", "735F696Ah", "6F6D6514h"} -- Piggy Starlet
  elseif choice == 31 then
    skins = {"00000000h", "00000000h", "00000000h", "2E313474h", "735F696Ah", "6F6D6514h"} -- Adventurous Chicken
  elseif choice == 32 then
    skins = {"00000000h", "00000000h", "00000000h", "2E303674h", "735F696Ah", "6F6D6514h"} -- Brazilian Carnival
  elseif choice == 33 then
    skins = {"00000000h", "00000000h", "00000000h", "2E313674h", "735F696Ah", "6F6D6514h"} -- Lantern Festival 2024
  elseif choice == 34 then
    skins = {"00000000h", "00000000h", "00000000h", "2E323674h", "735F696Ah", "6F6D6514h"} -- Irish Journey
  elseif choice == 35 then
    skins = {"00000000h", "00000000h", "00000000h", "2E333674h", "735F696Ah", "6F6D6514h"} -- Easter Adventure
  elseif choice == 36 then
    skins = {"00000000h", "00000000h", "00000000h", "2E343674h", "735F696Ah", "6F6D6514h"} -- Rock 'n' Roll Festival
  elseif choice == 37 then
    skins = {"00000000h", "00000000h", "00000000h", "2E353674h", "735F696Ah", "6F6D6514h"} -- Ancient World Chicken
  elseif choice == 38 then
    skins = {"00000000h", "00000000h", "00000000h", "2E363674h", "735F696Ah", "6F6D6514h"} -- Spy Games
  elseif choice == 39 then
    skins = {"00000000h", "00000000h", "00000000h", "2E373674h", "735F696Ah", "6F6D6514h"} -- Brotherhood of the Knights
  elseif choice == 40 then
    skins = {"00000000h", "00000000h", "00000000h", "2E383674h", "735F696Ah", "6F6D6514h"} -- Treasures of Atlantis
  elseif choice == 41 then
    skins = {"00000000h", "00000000h", "00000000h", "2E393674h", "735F696Ah", "6F6D6514h"} -- Wild Wild West
  elseif choice == 42 then
    skins = {"00000000h", "00000000h", "00000000h", "2E303774h", "735F696Ah", "6F6D6514h"} -- Beach Vacation
  elseif choice == 43 then
    skins = {"00000000h", "00000000h", "00000000h", "2E313774h", "735F696Ah", "6F6D6514h"} -- Italian Holiday
  elseif choice == 44 then
    skins = {"00000000h", "00000000h", "00000000h", "2E323774h", "735F696Ah", "6F6D6514h"} -- Sweet Birthday
  else
    return
  end
  hack_skins(skins)
end

---- DECORAÇÕES NAMORO/AMIZADE HACK
function hackd(choice)
  local skins = {}
  if choice == 0 then
    skins = {"00000072h", "65007200h", "72007265h", "6E006369h", "6E636950h", "67696212h"}
  elseif choice == 1 then
    skins = {"00000072h", "65007200h", "72000070h", "69007367h", "6E695765h", "766F6C12h"}
  elseif choice == 2 then
    skins = {"00000072h", "65007200h", "72000070h", "69007265h", "776F5465h", "766F6C12h"}
  elseif choice == 3 then
    skins = {"00000072h", "00706972h", "7474616Fh", "625F6573h", "756F6865h", "6B616C24h"}
  elseif choice == 4 then
    skins = {"00000073h", "00706972h", "00650065h", "75746174h", "735F6B72h", "6F747318h"}
  elseif choice == 5 then
    skins = {"25701", "1769108065", "1299477365", "1784636782", "1769238117", "1818318378"}
  elseif choice == 6 then
    skins = {"00007FFFh", "00656461h", "6E657265h", "735F656Eh", "69746E65h", "6C615624h"}
  elseif choice == 7 then
    skins = {"00003272h", "6165625Fh", "79646465h", "545F656Eh", "69746E65h", "6C61562Ah"}
  elseif choice == 8 then
    skins = {"00000072h", "6165625Fh", "79646465h", "545F656Eh", "69746E65h", "6C615628h"}
  elseif choice == 9 then
    skins = {"00007F00h", "64656272h", "65776F6Ch", "465F656Eh", "69746E65h", "6C615626h"}
  elseif choice == 10 then
    skins = {"00006E72h", "65746E61h", "6C5F7265h", "74736165h", "5F797475h", "6165622Ah"}
  elseif choice == 11 then
    skins = {"0073646Eh", "61486E49h", "74726165h", "685F656Eh", "69746E65h", "6C61562Ch"}
  elseif choice == 12 then
    skins = {"00007FFFh", "03006E61h", "6D776F6Eh", "535F7361h", "6D747369h", "72684322h"}
  elseif choice == 13 then
    skins = {"0", "0", "0", "-170065808", "1869108063", "1768641296"}
  elseif choice == 14 then
    skins = {"0", "0", "6645345", "1130328929", "1836348265", "1919435548"}
  elseif choice == 15 then
    skins = {"0", "0", "0", "1952803698", "1632460645", "1701991446"}
  elseif choice == 16 then
    skins = {"0", "0", "7498081", "1180660577", "1836348265", "1919435548"}
  elseif choice == 17 then
    skins = {"25959", "1684632130", "1601071457", "1918137185", "1836348265", "1919435562"}
  elseif choice == 18 then
    skins = {"0", "0", "101", "1937076040", "1601332583", "1852393240"}
  elseif choice == 19 then
    skins = {"0", "0", "0", "-170065806", "1634031967", "2003127824"}
  elseif choice == 20 then
    skins = {"00726570h", "6C65685Fh", "61746E61h", "735F7361h", "6D747369h", "7268632Ch"}
  elseif choice == 21 then
    skins = {"00007400h", "6B6E616Ch", "705F7365h", "7275006Fh", "6E690075h", "6C676908h"}
  elseif choice == 22 then
    skins = {"00007FFFh", "03354340h", "00650065h", "626F6C47h", "72616579h", "77654E18h"}
  elseif choice == 23 then
    skins = {"00006573h", "756F485Fh", "61746E61h", "535F7361h", "6D747369h", "7268432Ah"}
  elseif choice == 24 then
    skins = {"00000000h", "32323032h", "73616D78h", "5F747275h", "59726574h", "6E697726h"}
  elseif choice == 25 then
    skins = {"0000396Eh", "6F697461h", "72006E61h", "6D776F6Eh", "535F746Eh", "6169471Ah"}
  elseif choice == 26 then
    skins = {"00006B63h", "6F73746Eh", "65736572h", "705F7361h", "6D747369h", "7268432Ah"}
  elseif choice == 27 then
    skins = {"00007372h", "65670000h", "6B6E616Ch", "705F7468h", "67694677h", "6F6E731Eh"}
  elseif choice == 28 then
    skins = {"0000676Eh", "69006174h", "6E61735Fh", "65676465h", "6C736F62h", "72757422h"}
  elseif choice == 29 then
    skins = {"00007FFFh", "00636974h", "6372615Fh", "73676F64h", "5F797475h", "61656224h"}
  elseif choice == 30 then
    skins = {"00000065h", "74006E00h", "676E696Dh", "6F437361h", "6D747369h", "7268631Eh"}
  elseif choice == 31 then
    skins = {"00007FFFh", "05000065h", "73756F00h", "68676965h", "6C536174h", "6E615316h"}
  elseif choice == 32 then
    skins = {"00650065h", "7269685Fh", "68637469h", "775F6E65h", "65776F6Ch", "6C616828h"}
  elseif choice == 33 then
    skins = {"00657563h", "73650065h", "6C747361h", "635F6E65h", "65776F6Ch", "6C616820h"}
  elseif choice == 34 then
    skins = {"0000396Eh", "6F697461h", "726F6300h", "6E656472h", "61477473h", "6F684716h"}
  elseif choice == 35 then
    skins = {"00007FFFh", "00650000h", "726F6365h", "445F0074h", "6F506863h", "74695710h"}
  elseif choice == 36 then
    skins = {"00006E65h", "65776F6Ch", "6C61685Fh", "65757461h", "74536863h", "7469572Ah"}
  elseif choice == 37 then
    skins = {"00657563h", "006E6961h", "746E756Fh", "665F6E65h", "65776F6Ch", "6C616824h"}
  elseif choice == 38 then
    skins = {"00657500h", "776F7263h", "65726163h", "735F6E65h", "65776F6Ch", "6C616826h"}
  elseif choice == 39 then
    skins = {"00657500h", "776F7263h", "00656572h", "745F6E65h", "65776F6Ch", "6C61681Ch"}
  elseif choice == 40 then
    skins = {"00000065h", "74006E65h", "65776F6Ch", "6C61685Fh", "7265626Dh", "61686322h"}
  elseif choice == 41 then
    skins = {"00000000h", "6C610000h", "7961006Dh", "75696E65h", "64615F65h", "65727418h"}
  elseif choice == 42 then
    skins = {"00006566h", "66617269h", "675F6169h", "63616361h", "5F797475h", "6165622Ah"}
  elseif choice == 43 then
    skins = {"00006566h", "66610079h", "656E6175h", "67617261h", "5F797475h", "61656220h"}
  elseif choice == 44 then
    skins = {"00007FFFh", "05461280h", "0078696Eh", "6F6C6564h", "5F797475h", "6165621Ch"}
  elseif choice == 45 then
    skins = {"00000073h", "69007265h", "74007265h", "6E6E7572h", "00626162h", "6F61620Ch"}
  elseif choice == 46 then
    skins = {"00323230h", "3273616Dh", "785F6565h", "72547361h", "6D747369h", "7268632Ch"}
  elseif choice == 47 then
    skins = {"00730072h", "65007400h", "61697265h", "74736977h", "5F797475h", "6165621Eh"}
  elseif choice == 48 then
    skins = {"00007FFFh", "05006D6Ch", "61705F63h", "696E6966h", "5F797475h", "61656222h"}
  elseif choice == 49 then
    skins = {"00007FFFh", "05461280h", "00000000h", "00656572h", "545F7465h", "65775314h"}
  elseif choice == 50 then
    skins = {"00007FFFh", "05461280h", "00000000h", "6172756Bh", "61735F65h", "65725416h"}
  elseif choice == 51 then
    skins = {"00000073h", "65740065h", "6572745Fh", "656E6970h", "5F797475h", "61656220h"}
  elseif choice == 52 then
    skins = {"006E6F69h", "74617200h", "656C006Eh", "69665F31h", "00737574h", "6361630Ch"}
  elseif choice == 53 then
    skins = {"00006E65h", "65776F6Ch", "6C610065h", "00656572h", "745F656Ch", "70706114h"}
  
  elseif choice == 54 then
    skins = {"00007FFFh", "0E088A40h", "00000000h", "65676469h", "72427373h", "616C4716h"}
  elseif choice == 55 then
    skins = {"006E6F69h", "74617200h", "656C006Eh", "69665F30h", "30656764h", "69726218h"}
  elseif choice == 56 then
    skins = {"006E6F69h", "74617200h", "656C006Eh", "69665F31h", "30656764h", "69726218h"}
  elseif choice == 57 then
    skins = {"00007FFFh", "0500796Kh", "73006567h", "64697242h", "5F6F746Ch", "6169521Ah"}
  elseif choice == 58 then
    skins = {"00007400h", "6B6E0072h", "00000065h", "636E6566h", "5F797275h", "78756C18h"}
  elseif choice == 59 then
    skins = {"00000065h", "65727400h", "65636E65h", "665F7361h", "6D747369h", "7268431Eh"}
  elseif choice == 60 then
    skins = {"00006B63h", "00385000h", "00730065h", "636E6566h", "5F726574h", "73614518h"}
  elseif choice == 61 then
    skins = {"0", "0", "101", "1668179302", "1601332599", "1869375000"}
  elseif choice == 62 then
    skins = {"00656E00h", "73657461h", "675F7265h", "776F6C46h", "5F797475h", "61656226h"}

  elseif choice == 63 then
    skins = {"00007FFFh", "03006573h", "756F685Fh", "656B616Ch", "5F797475h", "61656222h"}
  elseif choice == 64 then
    skins = {"00000000h", "6E6F6974h", "61745372h", "616C6F70h", "5F797475h", "61656226h"}
  elseif choice == 65 then
    skins = {"00007FFFh", "0300656Ch", "74736163h", "5F656369h", "5F797475h", "61656222h"}
  elseif choice == 66 then
    skins = {"00007400h", "6B6E616Ch", "705F7365h", "72757470h", "6C756353h", "65636926h"}
  elseif choice == 67 then
    skins = {"0000676Eh", "69000078h", "00636974h", "6372615Fh", "68637241h", "6563691Ch"}
  elseif choice == 68 then
    skins = {"00007372h", "65670000h", "6B6E616Ch", "705F7468h", "67694677h", "6F6E731Eh"}
  elseif choice == 69 then
    skins = {"0000676Eh", "69000000h", "63697463h", "72615F6Eh", "616D7261h", "6C6F701Eh"}
  elseif choice == 70 then
    skins = {"00736E69h", "75676E65h", "50676E69h", "74616B73h", "5F797475h", "6165622Ch"}
  elseif choice == 71 then
    skins = {"00000072h", "656E6E75h", "725F6E6Fh", "69746962h", "69687845h", "65634928h"}
  elseif choice == 72 then
    skins = {"0000676Eh", "69000000h", "63690033h", "68637461h", "6D5F6564h", "696C7318h"}
  else
    return
  end
  hack_skins(skins)
end

---- SKINS NAVIO PORTO HACK
function hack55()
  hack_skins({"0", "0", "12628", "1398763625", "1750294382", "1768641306"})
end
function hack55b()
  hack_skins({"0", "0", "14672", "1398763625", "1750294382", "1768641306"})
end
function hack55c()
  hack_skins({"0", "0", "1936290401", "1885302889", "1750294382", "1768641310"})
end
function hack55d()
  hack_skins({"0", "101", "1667853925", "1985966185", "1750294382", "1768641312"})
end
function hack55e()
  hack_skins({"0", "1685014371", "1768190575", "1851748457", "1750294382", "1768641318"})
end
function hack55f()
  hack_skins({"0", "101", "1818717813", "1784639593", "1750294382", "1768641312"})
end
function hack55g()
  hack_skins({"0", "0", "22862", "1130328169", "1750294382", "1768641306"})
end
function hack55h()
  hack_skins({"0", "115", "1634495589", "1751085161", "1750294382", "1768641312"})
end
function hack55i()
  hack_skins({"0", "0", "1953528167", "1700753513", "1750294382", "1768641310"})
end
function hack55j()
  hack_skins({"0", "99", "1769235314", "1633644649", "1750294382", "1768641312"})
end
function hack55k()
  hack_skins({"00343230h", "32796164h", "68747269h", "625F7069h", "68535F6Eh", "696B532Ch"})
end
---- SKINS BASE PORTO HACK
function hack5()
  hack_skins({"0", "0", "3154535Fh", "726F6272h", "61485F6Eh", "696B531Eh"})
end
function hack5b()
  hack_skins({"0", "0", "3950535Fh", "726F6272h", "61485F6Eh", "696B531Eh"})
end
function hack5c()
  hack_skins({"0", "29545", "1918988383", "1919902322", "1632132974", "1768641314"})
end
function hack5d()
  hack_skins({"0", "00656369h", "6E65765Fh", "726F6272h", "61485F6Eh", "696B5324h"})
end
function hack5e()
  hack_skins({"0000646Fh", "47636964h", "726F6E5Fh", "726F6272h", "61485F6Eh", "696B532Ah"})
end
function hack5f()
  hack_skins({"0", "00656C67h", "6E756A5Fh", "726F6272h", "61485F6Eh", "696B5324h"})
end
function hack5g()
  hack_skins({"0", "0", "594E435Fh", "726F6272h", "61485F6Eh", "696B531Eh"})
end
function hack5h()
  hack_skins({"0", "0073616Ch", "6C65685Fh", "726F6272h", "61485F6Eh", "696B5324h"})
end
function hack5i()
  hack_skins({"0", "00007470h", "7967655Fh", "726F6272h", "61485F6Eh", "696B5322h"})
end
function hack5j()
  hack_skins({"0", "6515060", "1668440415", "1919902322", "1632132974", "1768641316"})
end

--- HACK SKINS AVIÃO DO AEROPORTO
function hack7()
  hack_skins({"0", "13136", "1398760814", "1634496626", "1765891950", "1768641314"})
end
function hack7b()
  hack_skins({"0", "14160", "1398760814", "1634496626", "1765891950", "1768641314"})
end
function hack7c()
  hack_skins({"0", "00003950h", "535F656Eh", "616C7072h", "69415F6Eh", "696B5322h"})
end
function hack7d()
  hack_skins({"0", "65636170h", "735F656Eh", "616C7072h", "69415F6Eh", "696B5326h"})
end
function hack7e()
  hack_skins({"0", "006B636Fh", "725F656Eh", "616C7072h", "69415F6Eh", "696B5324h"})
end
function hack7f()
  hack_skins({"0", "6569766Fh", "6D5F656Eh", "616C7072h", "69415F6Eh", "696B5326h"})
end
function hack7g()
  hack_skins({"0", "1952802167", "1935631726", "1634496626", "1765891950", "1768641318"})
end
function hack7h()
  hack_skins({"25710", "1634493810", "1767859566", "1634496626", "1765891950", "1768641322"})
end
function hack7i()
  hack_skins({"0", "31088", "1935631726", "1634496626", "1765891950", "1768641314"})
end
function hack7j()
  hack_skins({"00006E6Fh", "69687361h", "665F656Eh", "616C7072h", "69415F6Eh", "696B532Ah"})
end
--- HACK SKINS AEROPORTO
function hack6()
  hack_skins({"0", "00000033h", "50535F74h", "726F7072h", "69415F6Eh", "696B5320h"})
end
function hack6b()
  hack_skins({"0", "55", "1347641204", "1919905906", "1765891950", "1768641312"})
end
function hack6c()
  hack_skins({"0", "00000039h", "50535F74h", "726F7072h", "69415F6Eh", "696B5320h"})
end
function hack6d()
  hack_skins({"0", "6644577", "1886609268", "1919905906", "1765891950", "1768641316"})
end
function hack6e()
  hack_skins({"0", "27491", "1869766516", "1919905906", "1765891950", "1768641314"})
end
function hack6f()
  hack_skins({"0", "6646134", "1869438836", "1919905906", "1765891950", "1768641316"})
end
function hack6g()
  hack_skins({"0", "00746565h", "77735F74h", "726F7072h", "69415F6Eh", "696B5324h"})
end
function hack6h()
  hack_skins({"00000064h", "6E616C65h", "72695F74h", "726F7072h", "69415F6Eh", "696B5328h"})
end
function hack6i()
  hack_skins({"0", "00000079h", "70735F74h", "726F7072h", "69415F6Eh", "696B5320h"})
end
function hack6j()
  hack_skins({"0000006Eh", "6F696873h", "61665F74h", "726F7072h", "69415F6Eh", "696B5328h"})
end

--- HACK SKINS GALINHA
function hack8()
  hack_skins({"00000000h", "73616C6Ch", "65685F6Eh", "656B6369h", "68435F6Eh", "696B5326h"})
end
function hack8b()
  hack_skins({"00000000h", "656C676Eh", "756A5F6Eh", "656B6369h", "68435F6Eh", "696B5326h"})
end
function hack8c()
  hack_skins({"00000000h", "00746565h", "77735F6Eh", "656B6369h", "68435F6Eh", "696B5324h"})
end
function hack8d()
  hack_skins({"100", "1851878501", "1919508334", "1701536617", "1749245806", "1768641320"})
end
function hack8e()
  hack_skins({"00000000h", "0074726Fh", "70735F6Eh", "656B6369h", "68435F6Eh", "696B5324h"})
end
function hack8f()
  hack_skins({"00000000h", "6C657661h", "72745F6Eh", "656B6369h", "68435F6Eh", "696B5326h"})
end
function hack8g()
  hack_skins({"0000006Eh", "6F696873h", "61665F6Eh", "656B6369h", "68435F6Eh", "696B5328h"})
end

--- HACK SKINS VACAS
function hack9()
  hack_skins({"0", "0", "6646134", "1869438839", "1866686318", "1768641308"})
end
function hack9b()
  hack_skins({"3289648", "846422381", "1953720690", "1751342967", "1866686318", "1768641324"})
end
function hack9c()
  hack_skins({"0", "6647401", "1953391980", "1635147639", "1866686318", "1768641316"})
end
function hack9d()
  hack_skins({"0", "0", "29554", "1634557815", "1866686318", "1768641306"})
end
function hack9e()
  hack_skins({"0", "31073", "1684567154", "1768054647", "1866686318", "1768641314"})
end
function hack9f()
  hack_skins({"0", "0", "7628133", "2004049783", "1866686318", "1768641308"})
end
function hack9g()
  hack_skins({"0", "0", "846488933", "2004049783", "1866686318", "1768641310"})
end
function hack9h()
  hack_skins({"3355184", "846095717", "2003790956", "1634230135", "1866686318", "1768641324"})
end
function hack9i()
  hack_skins({"116", "1919905875", "1919251566", "1769430903", "1866686318", "1768641320"})
end
function hack9j()
  hack_skins({"0", "0", "89", "1313038199", "1866686318", "1768641304"})
end
function hack9k()
  hack_skins({"0", "875704370", "1919251571", "1634033527", "1866686318", "1768641318"})
end
function hack9l()
  hack_skins({"0", "0", "121", "1886609271", "1866686318", "1768641304"})
end
function hack9m()
  hack_skins({"0", "29545", "1953390956", "1952538487", "1866686318", "1768641314"})
end
function hack9n()
  hack_skins({"0", "3420720", "846818401", "1953062775", "1866686318", "1768641316"})
end
function hack9o()
  hack_skins({"13362", "808614241", "1684567154", "1768054647", "1866686318", "1768641322"})
end
function hack9p()
  hack_skins({"0", "875704370", "1702125938", "1768972151", "1866686318", "1768641318"})
end
function hack9q()
  hack_skins({"0", "0", "1667855459", "1918984055", "1866686318", "1768641310"})
end
function hack9r()
  hack_skins({"00006369h", "73756D63h", "69737361h", "6C635F77h", "6F435F6Eh", "696B532Ah"})
end

--- HACK SKINS OVELHA
function hack10()
  hack_skins({"3289648", "844713586", "1634628972", "1601201509", "1750294382", "1768641324"})
end
function hack10b()
  hack_skins({"13106", "808612453", "1953718629", "1601201509", "1750294382", "1768641322"})
end
function hack10c()
  hack_skins({"100", "1866949481", "1685221230", "1601201509", "1750294382", "1768641320"})
end
function hack10d()
  hack_skins({"101", "1986622563", "1702126948", "1601201509", "1750294382", "1768641320"})
end
function hack10e()
  hack_skins({"0", "116", "1701148531", "1601201509", "1750294382", "1768641312"})
end
function hack10f()
  hack_skins({"100", "1869564014", "1768058738", "1601201509", "1750294382", "1768641320"})
end
function hack10g()
  hack_skins({"0", "27753", "2053206626", "1601201509", "1750294382", "1768641314"})
end
function hack10h()
  hack_skins({"108", "1819243118", "1801678706", "1601201509", "1750294382", "1768641320"})
end
function hack10i()
  hack_skins({"0", "29800", "1734962795", "1601201509", "1750294382", "1768641314"})
end
function hack10j()
  hack_skins({"34323032h", "74736577h", "646C6977h", "5F706565h", "68535F6Eh", "696B532Eh"})
end
function hack10k()
  hack_skins({"34323032h", "79616468h", "74726962h", "5F706565h", "68535F6Eh", "696B532Eh"})
end
function hack10l()
  hack_skins({"0", "116", "1887004517", "1601201509", "1750294382", "1768641312"})
end
function hack10n()
  hack_skins({"00006564h", "61726575h", "7173616Dh", "5F706565h", "68535F6Eh", "696B532Ah"})
end

--- HACK SKIN ESTAÇÃO TRAIN
function hack002()
  hack_skins({"00003250h", "535F6E6Fh", "69746174h", "536E6961h", "72545F6Eh", "696B532Ah"})
end
function hack002b()
  hack_skins({"00003550h", "535F6E6Fh", "69746174h", "536E6961h", "72545F6Eh", "696B532Ah"})
end
function hack002c()
  hack_skins({"00003850h", "535F6E6Fh", "69746174h", "536E6961h", "72545F6Eh", "696B532Ah"})
end
function hack002d()
  hack_skins({"00737261h", "6D5F6E6Fh", "69746174h", "536E6961h", "72545F6Eh", "696B532Ch"})
end
--- HACK SKIN TRAIN
function hack01()
  hack_skins({"00000000h", "00000032h", "3A325053h", "5F6E6961h", "72545F6Eh", "696B5320h"})
end
function hack01b()
  hack_skins({"00000000h", "006E7265h", "74736577h", "5F6E6961h", "72545F6Eh", "696B5324h"})
end
function hack01c()
  hack_skins({"00000000h", "00000000h", "00355053h", "5F6E6961h", "72545F6Eh", "696B531Ch"})
end
function hack01d()
  hack_skins({"00000000h", "00000000h", "00385053h", "5F6E6961h", "72545F6Eh", "696B531Ch"})
end
function hack01e()
  hack_skins({"52", "842019449", "1818326121", "1601071457", "1918132078", "1768641320"})
end
function hack01ee()
  hack_skins({"00000073h", "616D7473h", "69726863h", "5F6E6961h", "72545F6Eh", "696B5328h"})
end
function hack01e2()
  hack_skins({"00000000h", "00007265h", "74736165h", "5F6E6961h", "72545F6Eh", "696B5322h"})
end
function hack01e3()
  hack_skins({"00323230h", "32594E72h", "616E756Ch", "5F6E6961h", "72545F6Eh", "696B532Ch"})
end
function hack01e4()
  hack_skins({"00636972h", "6F747369h", "68657270h", "5F6E6961h", "72545F6Eh", "696B532Ch"})
end
function hack01e5()
  hack_skins({"00006C61h", "63697274h", "61656874h", "5F6E6961h", "72545F6Eh", "696B532Ah"})
end
function hack01e6()
  hack_skins({"00000064h", "6F6F486Eh", "69626F72h", "5F6E6961h", "72545F6Eh", "696B5328h"})
end
function hack01e7()
  hack_skins({"00000000h", "00007468h", "67696E6Bh", "5F6E6961h", "72545F6Eh", "696B5322h"})
end
function hack01e8()
  hack_skins({"0000006Ch", "6C6F726Eh", "6B636F72h", "5F6E6961h", "72545F6Eh", "696B5328h"})
end
function hack01e9()
  hack_skins({"00000000h", "00000000h", "7372616Dh", "5F6E6961h", "72545F6Eh", "696B531Eh"})
end
---- CASTELO ILHA SKIN
function hack02()
  hack_skins({"00003165h", "74617269h", "505F7373h", "65727472h", "6F465F6Eh", "696B532Ah"})
end
function hack02b()
  hack_skins({"00000072h", "65747361h", "655F7373h", "65727472h", "6F465F6Eh", "696B5328h"})
end
function hack02c()
  hack_skins({"00003265h", "74617269h", "505F7373h", "65727472h", "6F465F6Eh", "696B532Ah"})
end
function hack02d()
  hack_skins({"00003379h", "62737461h", "475F7373h", "65727472h", "6F465F6Eh", "696B532Ah"})
end
function hack02e()
  hack_skins({"00003279h", "62737461h", "475F7373h", "65727472h", "6F465F6Eh", "696B532Ah"})
end
function hack02f()
  hack_skins({"0", "1936290401", "1885303667", "1701999730", "1866882926", "1768641318"})
end
function hack02g()
  hack_skins({"73616D74h", "73697268h", "435F7373h", "65727472h", "6F465F6Eh", "696B532Eh"})
end
---- PORCO SKIN
function hack03()
  hack_skins({"7954756", "1936027241", "1953391980", "1635147623", "1766874990", "1768641324"})
end
function hack03b()
  hack_skins({"0", "0", "89", "1313038183", "1766874990", "1768641304"})
end
---- FOTO PERFIL (Event Participation 2024)
function hack230() 
  hack_skins({"00000000h", "00000000h", "000000000h", "00000000h", "2E333233h", "6176610Ch"}) -- Heart of Shambala
end
function hack231() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E343233h", "6176610Ch"}) -- Infinite Adventure 
end
function hack232() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E363233h", "6176610Ch"}) -- Brazilian Carnival Event
end
function hack233() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E383233h", "6176610Ch"}) -- Legends of Greece Event
end
function hack234() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E393233h", "6176610Ch"}) -- Legendary Adventure
end
function hack235() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E303333h", "6176610Ch"}) -- Lantern Festival
end
function hack236() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E313333h", "6176610Ch"}) -- Retro Party
end
function hack237() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E333333h", "6176610Ch"}) -- Irish Journey
end
function hack238() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E343333h", "6176610Ch"}) -- Easter Adventure
end
function hack239() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E323333h", "6176610Ch"}) -- Craft Fair
end
function hack240() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E353333h", "6176610Ch"}) -- Rock 'n' Roll Festival
end
function hack241() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E363333h", "6176610Ch"}) -- Camping Trip Event
end
function hack242() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E373333h", "6176610Ch"}) -- Land of Wasps
end
function hack243() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E383333h", "6176610Ch"}) -- Legendary Adventure
end
function hack244() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E393333h", "6176610Ch"}) -- Ancient World
end
function hack245() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E303433h", "6176610Ch"}) -- Beach Festival Event
end
function hack246() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E313433h", "6176610Ch"}) -- Spy Games Event
end
function hack247() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E323433h", "6176610Ch"}) -- Trapped in Wonderland
end
function hack248() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E333433h", "6176610Ch"}) -- Legendary Adventure 2
end
function hack249() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E343433h", "6176610Ch"}) -- Secret Base Investigation
end
function hack250() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E353433h", "6176610Ch"}) -- Legendary Adventure 3
end
function hack251() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E363433h", "6176610Ch"}) -- Taste of Italy
end
function hack252() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E373433h", "6176610Ch"}) -- Brotherhood of the Knights
end
function hack253() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E383433h", "6176610Ch"}) -- Adventurer's Peak
end
function hack254() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E303533h", "6176610Ch"}) -- Treasures of Atlantis
end
function hack255() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E323533h", "6176610Ch"}) -- Survival Game
end
function hack256() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E393433h", "6176610Ch"}) -- Legendary Adventure 4
end
function hack257() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E333533h", "6176610Ch"}) -- Legendary Adventure 5
end
function hack258() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E343533h", "6176610Ch"}) -- Wild Wild West
end
function hack259() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E353533h", "6176610Ch"}) -- Beach Vacation
end
function hack260() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E363533h", "6176610Ch"}) -- Secrets of Area 551
end
function hack261() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E383533h", "6176610Ch"}) -- Italian Holiday 2
end
function hack262() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E393533h", "6176610Ch"}) -- Cave Expedition Event
end
function hack263() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E303633h", "6176610Ch"}) -- Legendary Adventure 6
end
function hack264() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E333633h", "6176610Ch"}) -- Sweet Birthday Event 2024
end
function hack265() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E343633h", "6176610Ch"}) -- Chocolate Factory Event
end
function hack266() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E353633h", "6176610Ch"}) -- Legendary Adventure 7
end
function hack267() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E363633h", "6176610Ch"}) -- Haunted Halloween
end
function hack268() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E373633h", "6176610Ch"}) -- The Case of the Dark Hound
end
function hack269() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E393633h", "6176610Ch"}) -- Legendary Adventure 8
end
function hack270() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E393633h", "6176610Ch"}) -- Egyptian Adventure Event
end
function hack271() 
  hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", "2E313733h", "6176610Ch"}) -- Misty Hills Event
end
--- Skins Helicoptero
function hackh1()
  hack_skins({"00000000h", "1868977503", "1919251568", "1868786028", "1699241838", "1768641318"})
end
function hackh2()
  hack_skins({"29807", "1651462751", "1919251568", "1868786028", "1699241838", "1768641322"})
end
function hackh3()
  hack_skins({"6842217", "1701598047", "1919251568", "1868786028", "1699241838", "1768641324"})
end
function hackh4()
  hack_skins({"7955059", "1952532319", "1919251568", "1868786028", "1699241838", "1768641324"})
end
function hackh5()
  hack_skins({"74736576h", "7261485Fh", "72657470h", "6F63696Ch", "65485F6Eh", "696B532Eh"})
end
function hackh6()
  hack_skins({"6515042", "1634877791", "1919251568", "1868786028", "1699241838", "1768641324"})
end
function hackh7()
  hack_skins({"7631471", "1936020063", "1919251568", "1868786028", "1699241838", "1768641324"})
end
function hackh8()
  hack_skins({"7103862", "1634882655", "1919251568", "1868786028", "1699241838", "1768641324"})
end
function hackh9()
  hack_skins({"29810", "1869632351", "1919251568", "1868786028", "1699241838", "1768641322"})
end

local eventos = {
  ---- Event Participation (2023) = (1 a 30)
  {"2E343732h", "Romantic Overlook"},
  {"2E303832h", "Postal Collapse"},
  {"2E363832h", "Lantern Festival Event"},
  {"2E373832h", "Love Fever"},
  {"2E383832h", "Gem Fever"},
  {"2E303932h", "Marathon Event March"},
  {"2E313932h", "Easter Fun"},
  {"2E323932h", "Wild Yeti Chase"},
  {"2E343932h", "Jazzy Makeover"},
  {"2E353932h", "Martian Odyssey"},
  {"2E363932h", "Pharaoh's Curse"},
  {"2E383932h", "Chinese Celebration"},
  {"2E303033h", "Fairytale Kingdom"},
  {"2E323033h", "Viking World"},
  {"2E343033h", "Botanical Bonanza"},
  {"2E353033h", "Detective Stories"},
  {"2E363033h", "Mysteries of Atlantis"},
  {"2E373033h", "Call of the Jungle"},
  {"2E383033h", "Lost Island"},
  {"2E393033h", "Culinary Adventure"},
  {"2E303133h", "Sweet Birthday"},
  {"2E353133h", "Mystery Estate"},
  {"2E373133h", "Vampire Party Event"},
  {"2E383133h", "Forest Adventure"},
  {"2E393133h", "Infinite Adventure"},
  {"2E303233h", "Klondike Expedition"},
  {"2E313233h", "Christmas Miracles"},
  {"2E323233h", "Sports Tournament"},
  {"2E353233h", "Sporty Winter"},
  {"2E373233h", "Winter Village Event"},
  ---- Conquistas Aniversário = (31 a 40)
  {"2E393131h", "1 Year"},
  {"2E303231h", "2 Year"},
  {"2E313231h", "3 Year"},
  {"00323231h", "4 Year"},
  {"2E333231h", "5 Year"},
  {"2E313931h", "7 Year"},
  {"00393332h", "8 Year"},
  {"00313832h", "9 Year"},
  {"00333133h", "10 Year"},
  {"2E313633h", "Celebrate"},
  ---- Complete Achievements = (41 a 47)
  {"002E3033h", "Calendar Pig"},
  {"002E3233h", "Service Sheep"},
  {"002E3333h", "Joyful Eugene"},
  {"002E3433h", "Ruler Sheep"},
  {"002E3533h", "Wise Chicken"},
  {"002E3633h", "Eugene and Susie"},
  {"002E3933h", "Miner Mole"},
}

function hack_photo(indice, tipo)
  local evento = eventos[indice]
  if evento then
    local final = tipo == 1 and "6176610Ch" or "6176610Ah"
    hack_skins({"00000000h", "00000000h", "00000000h", "00000000h", evento[1], final})
  end
end

function hackskn(mode)
  gg.processResume()
  gg.clearResults()
  gg.setVisible(false)

  -- Resetando as variáveis
  local s1c, s2c, s3c, s4c, s5c, s6c = nil, nil, nil, nil, nil, nil
  
  local searchPatterns = {
      "1852140576;1768641320;49;27;1768641316;1717920782::505", -- 1
      "1919509016;846815588;1768641324;49", -- 2
      "1969319970;49;1717920782:505", -- 3
      "1969319970;49;1717920782:505", -- 4
      "1969319970;49;1717920782:505", -- 5
      "1634230113;3420720;49;1717920782::501", -- 6
      "1634230113;3420720;49;1717920782::501", -- 7
      "1634230113;3420720;49;1717920782::501", -- 8
      "1852006265;842019449;49;1768641320::421", -- 9
      "1852006265;842019449;49;1768641320::421", -- 10
      "1919512596;3420720;49;1768641318::449", -- 11
      "1919512596;3420720;49;1768641318::449", -- 12
      "1852990756;49;1768641322", -- 13
      "1852990756;49;1768641322", -- 14
      "1852990752;49;1768641322", -- 15
      "1852990752;49;1768641322" -- 16
  }
  
  local offsets = {
      {0, 4, 8, 12, 16, 20}, -- 1
      {0, 4, 8, 12, 16, 20}, -- 2
      {0, 4, 8, 12, 16, 20}, -- 3
      {224, 228, 232, 236, 240, 244}, -- 4
      {248, 252, 256, 260, 264, 268}, -- 5
      {0, 4, 8, 12, 16, 20}, -- 6
      {224, 228, 232, 236, 240, 244}, -- 7
      {248, 252, 256, 260, 264, 268}, -- 8
      {0, 4, 8, 12, 16, 20}, -- 9
      {224, 228, 232, 236, 240, 244}, -- 10
      {176, 180, 184, 188, 192, 196}, -- 11
      {400, 404, 408, 412, 416, 420}, -- 12
      {0, 4, 8, 12, 16, 20}, -- 13
      {224, 228, 232, 236, 240, 244}, -- 14
      {0, 4, 8, 12, 16, 20}, -- 15
      {224, 228, 232, 236, 240, 244} -- 16
  }
  
  gg.searchNumber(searchPatterns[mode], gg.TYPE_DWORD)
  gg.refineNumber("49", gg.TYPE_DWORD)
  
  local results = gg.getResults(1)
  if #results < 1 then
      gg.alert("Erro: Nenhum resultado encontrado!")
      return
  end
  
  for _, offset in ipairs(offsets[mode]) do
      local temp = {
          address = results[1].address + offset,
          flags = gg.TYPE_DWORD,
          value = results[1].value
      }
      gg.addListItems({temp})
  end
  
  gg.clearResults()
  local tb = gg.getListItems()
  if #tb < 6 then
      gg.alert("Erro: Valores insuficientes na lista!")
      return
  end
  
  local s1c, s2c, s3c, s4c, s5c, s6c = tb[1].value, tb[2].value, tb[3].value, tb[4].value, tb[5].value, tb[6].value
  
  gg.clearResults()
  gg.searchNumber("1701996056;1651327333;99;5;30", gg.TYPE_DWORD)
  gg.refineNumber("30", gg.TYPE_DWORD)
  
  setd(-44, 1)
  setd(-48, 0)
  setd(-52, s6c)
  setd(-56, s5c)
  setd(-60, s4c)
  setd(-64, s3c)
  setd(-68, s2c)
  setd(-72, s1c)
end

function hackskp(mode)
  gg.processResume()
  gg.clearResults()
  gg.setVisible(false)

  -- Resetando as variáveis
  local s1c, s2c, s3c, s4c, s5c, s6c = nil, nil, nil, nil, nil, nil
  
  local searchPatterns = {
      "33;26;1953055504;1734955897::29", -- 1
      "33;26;1953055504;1734955897::29", -- 2
      "33;26;1953055504;1734955897::29", -- 3
      "33;26;1953055504;1734955897::29", -- 4
      "33;26;1953055504;1734955897::29", -- 5
      "33;26;1953055504;1734955897::29" -- 6
  }
  
  local offsets = {
      {-4, -8, 0, 4, 8, 12}, -- 1
      {-4, -8, 0, 4, 8, 12}, -- 2
      {-4, -8, 0, 4, 8, 12}, -- 3
      {-4, -8, 0, 4, 8, 12}, -- 4
      {-4, -8, 0, 4, 8, 12}, -- 5
      {-4, -8, 0, 4, 8, 12}, -- 6
  }
  
  gg.searchNumber(searchPatterns[mode], gg.TYPE_DWORD)
  gg.refineNumber("26", gg.TYPE_DWORD)

  local results = gg.getResults(mode)
  if #results < 1 then
      gg.alert("Erro: Nenhum resultado encontrado!")
      return
  end
  
  for _, offset in ipairs(offsets[mode]) do
      local temp = {
          address = results[mode].address + offset,
          flags = gg.TYPE_DWORD,
          value = results[mode].value
      }
      gg.addListItems({temp})
  end
  
  gg.clearResults()
  local tb = gg.getListItems()
  if #tb < 6 then
      gg.alert("Erro: Valores insuficientes na lista!")
      return
  end
  
  local s1c, s2c, s3c, s4c, s5c, s6c = tb[1].value, tb[2].value, tb[3].value, tb[4].value, tb[5].value, tb[6].value
  
  gg.clearResults()
  gg.searchNumber("1701996056;1651327333;99;5;30", gg.TYPE_DWORD)
  gg.refineNumber("30", gg.TYPE_DWORD)
  
  setd(-44, 1)
  setd(-48, 0)
  setd(-52, s6c)
  setd(-56, s5c)
  setd(-60, s4c)
  setd(-64, s3c)
  setd(-68, s2c)
  setd(-72, s1c)
end

function ItemPass()
  gg.clearResults()
  gg.clearList()
  gg.setRanges(gg.REGION_C_ALLOC)
  gg.getValues({{address = 0xABCDEF12, flags = gg.TYPE_DWORD}})
  gg.searchNumber("00010001h;65726618h;626D4165h;6E497261h;00000063h;00010001h;5F50531Ah::", gg.TYPE_DWORD)
  gg.refineNumber("1701996056", gg.TYPE_DWORD)
  n = gg.getResultCount()
  jz = gg.getResults(n)

  for i = 1, n do
    gg.addListItems({[1] = {address = jz[i].address - 8,flags = gg.TYPE_DWORD,freeze = true,value = "0",gg.TYPE_DWORD}})
    gg.addListItems({[1] = {address = jz[i].address - 12,flags = gg.TYPE_DWORD,freeze = true,value = "0",gg.TYPE_DWORD}})
    gg.addListItems({[1] = {address = jz[i].address - 16,flags = gg.TYPE_DWORD,freeze = true,value = "0",gg.TYPE_DWORD}})
  end 
end

local isItemFreezeEnabled = false
local isItemFreezeEnabled = false

function menuescolhas(menu_tipo)
  SalvarUltimoMenu(menu_tipo)
-- Variável de controle
local itemPass2Executed = false

if menu_tipo == 1 then

  -- Monta o label com ou sem ✓
  local freezeLabel = lng('⏳ ◦ Congelar Recompensa', '⏳ ◦ Freeze Reward', '⏳ ◦ Congelar Recompensa', '⏳ ◦ Bekukan Hadiah')
  if isItemFreezeEnabled then
    freezeLabel = freezeLabel .. ' ✓'
  end

  -- Monta dinamicamente o menu
  local menuOptions = {
    lng('🌟 ◦ Bilhete Dourado', '🌟 ◦ Golden Ticket', '🌟 ◦ Boleto Dorado', '🌟 ◦ Tiket Emas Premium'),
    freezeLabel
  }

  -- Adiciona opções extras se o freeze estiver ativado
  if isItemFreezeEnabled then
    table.insert(menuOptions, lng('🎲 • Skins/Decorações/Foto', '🎲 • Skins/Decorations/Photo', '🎲 • Skins/Decoraciones/Foto', '🎲 • Skin/ Dekorasi/ Foto'))
    table.insert(menuOptions, lng('♻️ • Boosters', '♻️ • Boosters', '♻️ • Impulsores', '♻️ • Booster'))
    table.insert(menuOptions, lng('🎫 • Cupons', '🎫 • Coupons', '🎫 • Cupones', '🎫 • Kupon'))
    table.insert(menuOptions, lng('💣 • Itens', '💣 • Itens', '💣 • Productos', '💣 • Produk'))
  end

  table.insert(menuOptions, lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali'))

  MNV = gg.choice(menuOptions, nil, [[╔══╗───────────╔═╗╔╗─╔╗───
╚╗╔╝╔═╗╔╦╦╗╔═╦╗║═╣║╚╗╠╣╔═╗
─║║─║╬║║║║║║║║║╠═║║║║║║║╬║
─╚╝─╚═╝╚══╝╚╩═╝╚═╝╚╩╝╚╝║╔╝
───────────────────────╚╝─]])

  if MNV == nil then return end

  if MNV == 1 then
    hack15()

  elseif MNV == 2 then
    isItemFreezeEnabled = not isItemFreezeEnabled
    if isItemFreezeEnabled and not itemPass2Executed then
      ItemPass()
      itemPass2Executed = true
    end

  elseif isItemFreezeEnabled and MNV == 3 then
    menuescolhas(4)

  elseif isItemFreezeEnabled and MNV == 4 then
    menuescolhas(28)

  elseif isItemFreezeEnabled and MNV == 5 then
    menuescolhas(5)

  elseif isItemFreezeEnabled and MNV == 6 then
    menuescolhas(2)

  elseif (not isItemFreezeEnabled and MNV == 3) or (isItemFreezeEnabled and MNV == 7) then
    MENU()
  end

  elseif menu_tipo == 2 then
    MNZ = gg.choice({
    lng('🐶 • Animais', '🐶 • Animals', '🐶 • Animales', '🐶 • Hewan'),
    lng('💣 • Mina', '💣 • Mine', '💣 • Mina', '💣 • Tambang'),
    lng('🏭 • Construção', '🏭 • Construction', '🏭 • Construcción', '🏭 • Konstruksi'),
    lng('🌟 • Gemas', '🌟 • Gems', '🌟 • Gemas', '🌟 • Permata'),
    lng('💎 • Lingotes', '💎 • Ingots', '💎 • Lingotes', '💎 • Batangan'),
    lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))
    
    if MNZ == nil then return end
    if MNZ == 1 then menuescolhas(77) end
    if MNZ == 2 then menuescolhas(7) end
    if MNZ == 3 then menuescolhas(8) end
    if MNZ == 4 then menuescolhas(9) end
    if MNZ == 5 then menuescolhas(26) end
    if MNZ == 6 then menuescolhas(1) end

  elseif menu_tipo == 3 then
    MNZ = gg.choice({
    lng('🐶 ◦ Animais', '🐶 ◦ Animals', '🐶 ◦ Animales', '🐶 ◦ Hewan'),
    lng('💣 ◦ Forja', '💣 ◦ Forge', '💣 ◦ Forja', '💣 ◦ Pandai Besi'),
    lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
  }, nil,[[╔══╗───────────╔═╗╔╗─╔╗───
╚╗╔╝╔═╗╔╦╦╗╔═╦╗║═╣║╚╗╠╣╔═╗
─║║─║╬║║║║║║║║║╠═║║║║║║║╬║
─╚╝─╚═╝╚══╝╚╩═╝╚═╝╚╩╝╚╝║╔╝
───────────────────────╚╝─]])
    
    if MNZ == nil then return end
    if MNZ == 1 then hack14() end
    if MNZ == 2 then hack2() end
    if MNZ == 3 then MENU() end

  elseif menu_tipo == 4 then
    MNZ = gg.choice({
      lng('🎲 • Skins', '🎲 • Skins', '🎲 • Skins', '🎲 • Skin'),
      lng('🎲 • Decorações', '🎲 • Decorations', '🎲 • Decoraciones', '🎲 • Dekorasi'),
      lng('🎲 • Foto Perfil', '🎲 • Profile Photo', '🎲 • Foto de Perfil', '🎲 • Foto Profil'),
      lng('🎲 • Placas', '🎲 • Plates', '🎲 • Placas', '🎲 • Pelat'),
      lng('🎲 • Adesivos', '🎲 • Stickers', '🎲 • Pegatinas', '🎲 • Stiker'),
      lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))
    
    if MNZ == nil then return end
    if MNZ == 1 then menuescolhas(10) end
    if MNZ == 2 then menuescolhas(21) end
    if MNZ == 3 then menuescolhas(24) end
    if MNZ == 4 then menuescolhas(33) end
    if MNZ == 5 then menuescolhas(35) end
    if MNZ == 6 then menuescolhas(1) end

  elseif menu_tipo == 5 then
    MNC = gg.choice({
      lng('🎫 ◦ Cupom Pedidos', '🎫 ◦ Coupon Orders', '🎫 ◦ Órdenes Cupones', '🎫 ◦ Kupon Pesanan'),
      lng('🎫 ◦ Cupom Expansão', '🎫 ◦ Expansion Coupon', '🎫 ◦ Cupón Expansión', '🎫 ◦ Kupon Perluasan'),
      lng('🎫 ◦ Cupom Celeiro', '🎫 ◦ Barn Coupon', '🎫 ◦ Cupón Granero', '🎫 ◦ Kupon Gudang'),
      lng('🎫 ◦ Cupom Industria', '🎫 ◦ Industry Coupon', '🎫 ◦ Cupón Industria', '🎫 ◦ Kupon Industri'),
      lng('🎫 ◦ Cupom Train', '🎫 ◦ Train Coupon', '🎫 ◦ Cupón Tren', '🎫 ◦ Kupon Kereta'),
      lng('🎫 ◦ Cupom Ilha', '🎫 ◦ Island Coupon', '🎫 ◦ Cupón Isla', '🎫 ◦ Kupon Pulau'),
      lng('🎫 ◦ Cupom Mercado', '🎫 ◦ Hire Dealer Coupon', '🎫 ◦ Cupón Comerciante', '🎫 ◦ Kupon Pedagang'),
      lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))
    
    if MNC == nil then return end
    if MNC == 1 then hack("a") end
    if MNC == 2 then hack("b") end
    if MNC == 3 then hack("c") end
    if MNC == 4 then hack("d") end
    if MNC == 5 then hack("e") end
    if MNC == 6 then hack("f") end
    if MNC == 7 then hack("mm") end
    if MNC == 8 then menuescolhas(1) end
  
  elseif menu_tipo == 6 then
    MNF = gg.choice({
      lng("🍀 ◦ Xp (Trigo)", "🍀 ◦ Xp (Wheat)", "🍀 ◦ Xp (Trigo)", "🍀 ◦ Xp (Gandum)"),
      lng('🏭 ◦ Academia Industria', '🏭 ◦ Industry Academy', '🏭 ◦ Academia Industrial', '🏭 ◦ Akademi Industri'),
      lng('📦 ◦ Mercado Da Cidade', '📦 ◦ City Market', '📦 ◦ Mercado De La Ciudad', '📦 ◦ Pasar Kota'),
      lng('🚀 ◦ Heli Auto', '🚀 ◦ Heli Auto', '🚀 ◦ Heli Auto', '🚀 ◦ Heli Otomatis'),
      lng('💺 ◦ Avião Auto', '💺 ◦ Auto Plane', '💺 ◦ Avión Auto', '💺 ◦ Pesawat Otomatis'),
      lng('👾 ◦ Congelar População', '👾 ◦ Freeze Population', '👾 ◦ Congelar Población', '👾 ◦ Bekukan Populasi'),
      lng('❌ ◦ Voltar', '❌ • Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,[[╔══╗───────────╔═╗╔╗─╔╗───
╚╗╔╝╔═╗╔╦╦╗╔═╦╗║═╣║╚╗╠╣╔═╗
─║║─║╬║║║║║║║║║╠═║║║║║║║╬║
─╚╝─╚═╝╚══╝╚╩═╝╚═╝╚╩╝╚╝║╔╝
───────────────────────╚╝─]])

    if MNF == nil then return end
    if MNF == 1 then hack16() end
    if MNF == 2 then hack2C() end
    if MNF == 3 then hack13() end
    if MNF == 4 then hack12() end
    if MNF == 5 then hack("lv6") end
    if MNF == 6 then hack25() end
    if MNF == 7 then MENU() end

  elseif menu_tipo == 7 then
    MNM = gg.choice({
      lng('💣 ◦ Dinamite', '💣 ◦ Dynamite', '💣 ◦ Dinamita', '💣 ◦ Dinamit'),
      lng('💣 ◦ Picareta', '💣 ◦ Pick', '💣 ◦ Pico', '💣 ◦ Kapak'),
      lng('💣 ◦ Explosivo', '💣 ◦ Explosive', '💣 ◦ Explosivo', '💣 ◦ Bahan Peledak'),
      lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MNM == nil then return end
    if MNM == 1 then hack("g") end
    if MNM == 2 then hack("h") end
    if MNM == 3 then hack("i") end
    if MNM == 4 then menuescolhas(2) end

  elseif menu_tipo == 77 then
    MNM = gg.choice({
      lng('🐶 ◦ Bacon', '🐶 ◦ Bacon', '🐶 ◦ Tocino', '🐶 ◦ Bacon'),
      lng('🐶 ◦ Ovo', '🐶 ◦ Egg', '🐶 ◦ Huevo', '🐶 ◦ Telur'),
      lng('🐶 ◦ Mel', '🐶 ◦ Honey', '🐶 ◦ Miel', '🐶 ◦ Madu'),
      lng('🐶 ◦ Leite', '🐶 ◦ Milk', '🐶 ◦ Leche', '🐶 ◦ Susu'),
      lng('🐶 ◦ Lã', '🐶 ◦ Wool', '🐶 ◦ Allá', '🐶 ◦ Wol'),
      lng('🐶 ◦ Cogumelo', '🐶 ◦ Mushroom', '🐶 ◦ Champiñón', '🐶 ◦ Jamur'),
      lng('🐶 ◦ Ração Vacas', '🐶 ◦ Cow Feed', '🐶 ◦ Alimento Vacas', '🐶 ◦ Pakan Sapi'),
      lng('🐶 ◦ Ração Galinha', '🐶 ◦ Chicken Feed', '🐶 ◦ Comida Gallina', '🐶 ◦ Pakan Ayam'),
      lng('🐶 ◦ Ração Ovelha', '🐶 ◦ Sheep Feed', '🐶 ◦ Comida Oveja', '🐶 ◦ Pakan Domba'),
      lng('🐶 ◦ Ração Abelha', '🐶 ◦ Bee Feed', '🐶 ◦ Comida Abeja', '🐶 ◦ Pakan Lebah'),
      lng('🐶 ◦ Ração Porco', '🐶 ◦ Pig Feed', '🐶 ◦ Comida Cerdo', '🐶 ◦ Pakan Babi'),
      lng('🐶 ◦ Ração Cogumelo', '🐶 ◦ Mushroom Feed', '🐶 ◦ Comida Champiñón', '🐶 ◦ Pakan Jamur'),
      lng('❌ ◦ Voltar', '❌ • Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MNM == nil then return end
    if MNM == 1 then hack("p1") end
    if MNM == 2 then hack("p2") end
    if MNM == 3 then hack("p3") end
    if MNM == 4 then hack("p4") end
    if MNM == 5 then hack("p5") end
    if MNM == 6 then hack("p55") end
    if MNM == 7 then hack("p6") end
    if MNM == 8 then hack("p7") end
    if MNM == 9 then hack("p8") end
    if MNM == 10 then hack("p9") end
    if MNM == 11 then hack("p10") end
    if MNM == 12 then hack("p11") end
    if MNM == 13 then menuescolhas(2) end

  elseif menu_tipo == 8 then
    MNN = gg.choice({
      lng('🏭 ◦ Vidro', '🏭 ◦ Glass', '🏭 ◦ Vidrio', '🏭 ◦ Kaca'),
      lng('🏭 ◦ Tijolo', '🏭 ◦ Brick', '🏭 ◦ Ladrillo', '🏭 ◦ Bata'),
      lng('🏭 ◦ Laje', '🏭 ◦ Slab', '🏭 ◦ Losa', '🏭 ◦ Pelat'),
      lng('🏭 ◦ Serra', '🏭 ◦ Saw', '🏭 ◦ Sierra', '🏭 ◦ Gergaji'),
      lng('🏭 ◦ Britadeira', '🏭 ◦ Jackhammer', '🏭 ◦ Martillo Neumático', '🏭 ◦ Palu Jack'),
      lng('🏭 ◦ Furadeira', '🏭 ◦ Drill', '🏭 ◦ Taladro', '🏭 ◦ Bor'),
      lng('🏭 ◦ Prego', '🏭 ◦ Nail', '🏭 ◦ Clavo', '🏭 ◦ Paku'),
      lng('🏭 ◦ Martelo', '🏭 ◦ Hammer', '🏭 ◦ Martillo', '🏭 ◦ Palu'),
      lng('🏭 ◦ Tinta', '🏭 ◦ Red Paint', '🏭 ◦ Tinta', '🏭 ◦ Cat'),
      lng('🏭 ◦ Machado', '🏭 ◦ Axe', '🏭 ◦ Hacha', '🏭 ◦ Kapak'),
      lng('🏭 ◦ Pá', '🏭 ◦ Shovel', '🏭 ◦ Pala', '🏭 ◦ Sekop'),
      lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MNN == nil then return end
    if MNN == 1 then hack("j") end
    if MNN == 2 then hack("k") end
    if MNN == 3 then hack("l") end
    if MNN == 4 then hack("j2") end
    if MNN == 5 then hack("k2") end
    if MNN == 6 then hack("l2") end
    if MNN == 7 then hack("l3") end
    if MNN == 8 then hack("l4") end
    if MNN == 9 then hack("l5") end
    if MNN == 10 then hack("l6") end
    if MNN == 11 then hack("l7") end
    if MNN == 12 then menuescolhas(2) end

  elseif menu_tipo == 9 then
    MNU = gg.choice({
      lng('💎 ◦ Topázio', '💎 ◦ Topaz', '💎 ◦ Topacio', '💎 ◦ Topaz'),
      lng('💎 ◦ Esmeralda', '💎 ◦ Emerald', '💎 ◦ Esmeralda', '💎 ◦ Emerald'),
      lng('💎 ◦ Rubi', '💎 ◦ Ruby', '💎 ◦ Rubí', '💎 ◦ Ruby'),
      lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MNU == nil then return end
    if MNU == 1 then hack("n") end
    if MNU == 2 then hack("m") end
    if MNU == 3 then hack("o") end
    if MNU == 4 then menuescolhas(2) end

  elseif menu_tipo == 999 then
    MNU = gg.choice({
      lng('💵 ◦ Helicóptero', '💵 ◦ Helicopter', '💵 ◦ Helicóptero', '💵 ◦ Helikopter'),
      lng('💵 ◦ Notas', '💵 ◦ T-Cash', '💵 ◦ T-Cash', '💵 ◦ T-Cash'),
      lng('💵 ◦ Dinheiro', '💵 ◦ Money', '💵 ◦ Dinero', '💵 ◦ Uang'),
      lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MNU == nil then return end
    if MNU == 1 then hack11()  end
    if MNU == 2 then hack("ld2")  end
    if MNU == 3 then hack("ld1") end
    if MNU == 4 then MENU() end

  elseif menu_tipo == 10 then
    MNH = gg.choice({
      lng('🎲 ◦ Base Porto', '🎲 ◦ Base Port', '🎲 ◦ Base Portuaria', '🎲 ◦ Pangkalan Pelabuhan'),
      lng('🎲 ◦ Navio Do Porto', '🎲 ◦ Ship Port', '🎲 ◦ Puerto de Barcos', '🎲 ◦ Kapal Pelabuhan'),
      lng('🎲 ◦ Aeroporto', '🎲 ◦ Airport', '🎲 ◦ Aeropuerto', '🎲 ◦ Bandara'),
      lng('🎲 ◦ Avião Do Aeroporto', '🎲 ◦ Plane', '🎲 ◦ Avión', '🎲 ◦ Pesawat'),
      lng('🎲 ◦ Ovelha', '🎲 ◦ Sheep', '🎲 ◦ Oveja', '🎲 ◦ Domba'),
      lng('🎲 ◦ Galinha', '🎲 ◦ Hen', '🎲 ◦ Gallina', '🎲 ◦ Ayam Betina'),
      lng('🎲 ◦ Vaca', '🎲 ◦ Cow', '🎲 ◦ Vaca', '🎲 ◦ Sapi'),
      lng('🎲 ◦ Porco', '🎲 ◦ Pig', '🎲 ◦ Cerdo', '🎲 ◦ Babi'),
      lng('🎲 ◦ Estação De Train', '🎲 ◦ Station Train', '🎲 ◦ Estación de Tren', '🎲 ◦ Stasiun Kereta'),
      lng('🎲 ◦ Train Da Estação', '🎲 ◦ Train', '🎲 ◦ Tren', '🎲 ◦ Kereta'),
      lng('🎲 ◦ Castelo Ilha', '🎲 ◦ Island Castle', '🎲 ◦ Castillo de Isla', '🎲 ◦ Kastil Pulau'),
      lng('🎲 ◦ Heliporto', '🎲 ◦ Helipad', '🎲 ◦ Helipuerto', '🎲 ◦ Helipad'),
      lng('🎲 ◦ Helicóptero', '🎲 ◦ Helicopter', '🎲 ◦ Helicóptero', '🎲 ◦ Helikopter'),
      lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MNH == nil then return end
    if MNH == 1 then menuescolhas(11) end
    if MNH == 2 then menuescolhas(12) end
    if MNH == 3 then menuescolhas(14) end
    if MNH == 4 then menuescolhas(15) end
    if MNH == 5 then menuescolhas(16) end
    if MNH == 6 then menuescolhas(13) end
    if MNH == 7 then menuescolhas(17) end
    if MNH == 8 then menuescolhas(32) end
    if MNH == 9 then menuescolhas(18) end
    if MNH == 10 then menuescolhas(19) end
    if MNH == 11 then menuescolhas(20) end
    if MNH == 12 then menuescolhas(188) end
    if MNH == 13 then menuescolhas(199) end
    if MNH == 14 then menuescolhas(4) end

  elseif menu_tipo == 11 then
    MNK = gg.choice({
      lng('🎲 ◦ ST1', '🎲 ◦ ST1', '🎲 ◦ ST1', '🎲 ◦ ST1'),
      lng('🎲 ◦ SP9', '🎲 ◦ SP9', '🎲 ◦ SP9', '🎲 ◦ SP9'),
      lng('🎲 ◦ Paris', '🎲 ◦ Paris', '🎲 ◦ París', '🎲 ◦ Paris'),
      lng('🎲 ◦ Venice', '🎲 ◦ Venice', '🎲 ◦ Venecia', '🎲 ◦ Venesia'),
      lng('🎲 ◦ Nordic God', '🎲 ◦ Nordic God', '🎲 ◦ Dios Nórdico', '🎲 ◦ Dewa Nordik'),
      lng('🎲 ◦ Jungle', '🎲 ◦ Jungle', '🎲 ◦ Jungla', '🎲 ◦ Hutan'),
      lng('🎲 ◦ CNY', '🎲 ◦ CNY', '🎲 ◦ CNY', '🎲 ◦ CNY'),
      lng('🎲 ◦ Hellas', '🎲 ◦ Hellas', '🎲 ◦ Grecia', '🎲 ◦ Hellas'),
      lng('🎲 ◦ Egypt', '🎲 ◦ Egypt', '🎲 ◦ Egipto', '🎲 ◦ Mesir'),
      lng('🎲 ◦ Arctic', '🎲 ◦ Arctic', '🎲 ◦ Ártico', '🎲 ◦ Arktik'),
      lng('🎲 ◦ Sweet', '🎲 ◦ Sweet', '🎲 ◦ Dulce', '🎲 ◦ Manis'),
      lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MNK == nil then return end
    if MNK == 1 then hack5() end
    if MNK == 2 then hack5b() end
    if MNK == 3 then hack5c() end
    if MNK == 4 then hack5d() end
    if MNK == 5 then hack5e() end
    if MNK == 6 then hack5f() end
    if MNK == 7 then hack5g() end
    if MNK == 8 then hack5h() end
    if MNK == 9 then hack5i() end
    if MNK == 10 then hack5j() end
    if MNK == 11 then hackskn(2) end
    if MNK == 12 then menuescolhas(10) end

  elseif menu_tipo == 12 then
    MNL = gg.choice({
      lng('🎲 ◦ ST1', '🎲 ◦ ST1', '🎲 ◦ ST1', '🎲 ◦ ST1'),
      lng('🎲 ◦ SP9', '🎲 ◦ SP9', '🎲 ◦ SP9', '🎲 ◦ SP9'),
      lng('🎲 ◦ Paris', '🎲 ◦ Paris', '🎲 ◦ París', '🎲 ◦ Paris'),
      lng('🎲 ◦ Venice', '🎲 ◦ Venice', '🎲 ◦ Venecia', '🎲 ◦ Venesia'),
      lng('🎲 ◦ Nordic God', '🎲 ◦ Nordic God', '🎲 ◦ Dios Nórdico', '🎲 ◦ Dewa Nordik'),
      lng('🎲 ◦ Jungle', '🎲 ◦ Jungle', '🎲 ◦ Jungla', '🎲 ◦ Hutan'),
      lng('🎲 ◦ CNY', '🎲 ◦ CNY', '🎲 ◦ CNY', '🎲 ◦ CNY'),
      lng('🎲 ◦ Hellas', '🎲 ◦ Hellas', '🎲 ◦ Grecia', '🎲 ◦ Hellas'),
      lng('🎲 ◦ Egypt', '🎲 ◦ Egypt', '🎲 ◦ Egipto', '🎲 ◦ Mesir'),
      lng('🎲 ◦ Arctic', '🎲 ◦ Arctic', '🎲 ◦ Ártico', '🎲 ◦ Arktik'),
      lng('🎲 ◦ Sweet', '🎲 ◦ Sweet', '🎲 ◦ Dulce', '🎲 ◦ Manis'),
      lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MNL == nil then return end
    if MNL == 1 then hack55() end
    if MNL == 2 then hack55b() end
    if MNL == 3 then hack55c() end
    if MNL == 4 then hack55d() end
    if MNL == 5 then hack55e() end
    if MNL == 6 then hack55f() end
    if MNL == 7 then hack55g() end
    if MNL == 8 then hack55h() end
    if MNL == 9 then hack55i() end
    if MNL == 10 then hack55j() end
    if MNL == 11 then hack55k() end
    if MNL == 12 then menuescolhas(10) end

  elseif menu_tipo == 13 then
    MNE = gg.choice({
lng('🎲 ◦ Túnica', '🎲 ◦ Tunic', '🎲 ◦ Túnica', '🎲 ◦ Tunik'),
lng('🎲 ◦ Exploradora', '🎲 ◦ Explorer', '🎲 ◦ Exploradora', '🎲 ◦ Penjelajah'),
lng('🎲 ◦ Aniversário', '🎲 ◦ Birthday', '🎲 ◦ Cumpleaños', '🎲 ◦ Ulang Tahun'),
lng('🎲 ◦ Duende', '🎲 ◦ Elf', '🎲 ◦ Duende', '🎲 ◦ Peri'),
lng('🎲 ◦ Torcida', '🎲 ◦ Fan', '🎲 ◦ Hincha', '🎲 ◦ Penggemar'),
lng('🎲 ◦ Pilota', '🎲 ◦ Pilot', '🎲 ◦ Piloto', '🎲 ◦ Pilot'),
lng('🎲 ◦ Vacation', '🎲 ◦ Vacation', '🎲 ◦ Vacaciones', '🎲 ◦ Liburan'),
lng('🎲 ◦ Halloween', '🎲 ◦ Halloween', '🎲 ◦ Halloween', '🎲 ◦ Halloween'),
lng('🎲 ◦ Fashion', '🎲 ◦ Fashion', '🎲 ◦ Fashion', '🎲 ◦ Mode'),
lng('🎲 ◦ Bruxa', '🎲 ◦ Witch', '🎲 ◦ Bruja', '🎲 ◦ Penyihir'),
lng('🎲 ◦ Festa', '🎲 ◦ Party', '🎲 ◦ Fiesta', '🎲 ◦ Pesta'),
lng('🎲 ◦ Festiva', '🎲 ◦ Festive', '🎲 ◦ Festiva', '🎲 ◦ Meriah'),
lng('🎲 ◦ Férias', '🎲 ◦ Vacation', '🎲 ◦ Vacaciones', '🎲 ◦ Liburan'),
lng('🎲 ◦ Ajudante', '🎲 ◦ Helper', '🎲 ◦ Ayudante', '🎲 ◦ Pembantu'),
lng('🎲 ◦ Encantada', '🎲 ◦ Enchanted', '🎲 ◦ Encantada', '🎲 ◦ Terkutuk'),
lng('🎲 ◦ Arlequina', '🎲 ◦ Harlequin', '🎲 ◦ Arlequina', '🎲 ◦ Badut'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MNE == nil then return end
    if MNE == 1 then hack8() end
    if MNE == 2 then hack8b() end
    if MNE == 3 then hack8c() end
    if MNE == 4 then hack8d() end
    if MNE == 5 then hack8e() end
    if MNE == 6 then hack8f() end
    if MNE == 7 then hackskn(5) end
    if MNE == 8 then hackskn(8) end
    if MNE == 9 then hack8g() end
    if MNE == 10 then skinscp(16) end
    if MNE == 11 then skinscp(17) end
    if MNE == 12 then skinscp(18) end
    if MNE == 13 then skinscp(19) end
    if MNE == 14 then skinscp(20) end
    if MNE == 15 then skinscp(21) end
    if MNE == 16 then skinscp(22) end
    if MNE == 17 then menuescolhas(10) end

  elseif menu_tipo == 14 then
    MNI = gg.choice({
lng('🎲 ◦ SP3', '🎲 ◦ SP3', '🎲 ◦ SP3', '🎲 ◦ SP3'),
lng('🎲 ◦ SP7', '🎲 ◦ SP7', '🎲 ◦ SP7', '🎲 ◦ SP7'),
lng('🎲 ◦ SP9', '🎲 ◦ SP9', '🎲 ◦ SP9', '🎲 ◦ SP9'),
lng('🎲 ◦ Space', '🎲 ◦ Space', '🎲 ◦ Espacio', '🎲 ◦ Ruang'),
lng('🎲 ◦ Rock', '🎲 ◦ Rock', '🎲 ◦ Roca', '🎲 ◦ Rock'),
lng('🎲 ◦ Movie', '🎲 ◦ Movie', '🎲 ◦ Película', '🎲 ◦ Film'),
lng('🎲 ◦ Sweet', '🎲 ◦ Sweet', '🎲 ◦ Dulce', '🎲 ◦ Manis'),
lng('🎲 ◦ Ireland', '🎲 ◦ Ireland', '🎲 ◦ Irlanda', '🎲 ◦ Irlandia'),
lng('🎲 ◦ Spy', '🎲 ◦ Spy', '🎲 ◦ Espía', '🎲 ◦ Mata-mata'),
lng('🎲 ◦ Vacation', '🎲 ◦ Vacation', '🎲 ◦ Vacaciones', '🎲 ◦ Liburan'),
lng('🎲 ◦ Classic Music', '🎲 ◦ Classic Music', '🎲 ◦ Sinfónico', '🎲 ◦ Musik Klasik'),
lng('🎲 ◦ Fashion', '🎲 ◦ Fashion', '🎲 ◦ Fashion', '🎲 ◦ Mode'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')  
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MNI == nil then return end
    if MNI == 1 then hack6() end
    if MNI == 2 then hack6b() end
    if MNI == 3 then hack6c() end
    if MNI == 4 then hack6d() end
    if MNI == 5 then hack6e() end
    if MNI == 6 then hack6f() end
    if MNI == 7 then hack6g() end
    if MNI == 8 then hack6h() end
    if MNI == 9 then hack6i() end
    if MNI == 10 then hackskn(4) end
    if MNI == 11 then hackskn(14) end
    if MNI == 12 then hack6j() end
    if MNI == 13 then menuescolhas(10) end

  elseif menu_tipo == 15 then
    MNO = gg.choice({
lng('🎲 ◦ SP3', '🎲 ◦ SP3', '🎲 ◦ SP3', '🎲 ◦ SP3'),
lng('🎲 ◦ SP7', '🎲 ◦ SP7', '🎲 ◦ SP7', '🎲 ◦ SP7'),
lng('🎲 ◦ SP9', '🎲 ◦ SP9', '🎲 ◦ SP9', '🎲 ◦ SP9'),
lng('🎲 ◦ Space', '🎲 ◦ Space', '🎲 ◦ Espacio', '🎲 ◦ Ruang'),
lng('🎲 ◦ Rock', '🎲 ◦ Rock', '🎲 ◦ Roca', '🎲 ◦ Batu'),
lng('🎲 ◦ Movie', '🎲 ◦ Movie', '🎲 ◦ Película', '🎲 ◦ Film'),
lng('🎲 ◦ Sweet', '🎲 ◦ Sweet', '🎲 ◦ Dulce', '🎲 ◦ Manis'),
lng('🎲 ◦ Ireland', '🎲 ◦ Ireland', '🎲 ◦ Irlanda', '🎲 ◦ Irlandia'),
lng('🎲 ◦ Spy', '🎲 ◦ Spy', '🎲 ◦ Espía', '🎲 ◦ Mata-mata'),
lng('🎲 ◦ Vacation', '🎲 ◦ Vacation', '🎲 ◦ Vacaciones', '🎲 ◦ Liburan'),
lng('🎲 ◦ Classic Music', '🎲 ◦ Sinfônico', '🎲 ◦ Classic Music', '🎲 ◦ Musik Klasik'),
lng('🎲 ◦ Fashion', '🎲 ◦ Fashion', '🎲 ◦ Fashion', '🎲 ◦ Mode'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali') 
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MNO == nil then return end
    if MNO == 1 then hack7() end
    if MNO == 2 then hack7b() end
    if MNO == 3 then hack7c() end
    if MNO == 4 then hack7d() end
    if MNO == 5 then hack7e() end
    if MNO == 6 then hack7f() end
    if MNO == 7 then hack7g() end
    if MNO == 8 then hack7h() end
    if MNO == 9 then hack7i() end
    if MNO == 10 then hackskn(3) end
    if MNO == 11 then hackskn(13) end
    if MNO == 12 then hack7j() end
    if MNO == 13 then menuescolhas(10) end

  elseif menu_tipo == 16 then
    MNY = gg.choice({
lng('🎲 ◦ Lunar NY 2022', '🎲 ◦ Lunar NY 2022', '🎲 ◦ Año Nuevo Lunar 2022', '🎲 ◦ Tahun Baru Imlek 2022'),
lng('🎲 ◦ Easter 2023', '🎲 ◦ Easter 2023', '🎲 ◦ Pascua 2023', '🎲 ◦ Paskah 2023'),
lng('🎲 ◦ Nordic God', '🎲 ◦ Nordic God', '🎲 ◦ Dios Nórdico', '🎲 ◦ Dewa Nordik'),
lng('🎲 ◦ Detetive', '🎲 ◦ Detective', '🎲 ◦ Detective', '🎲 ◦ Detektif'),
lng('🎲 ◦ Sweet', '🎲 ◦ Sweet', '🎲 • Dulce', '🎲 ◦ Manis'),
lng('🎲 ◦ Robinhood', '🎲 ◦ Robinhood', '🎲 ◦ Robin Hood', '🎲 ◦ Robin Hood'),
lng('🎲 ◦ Brazil', '🎲 ◦ Brazil', '🎲 • Brasil', '🎲 ◦ Brasil'),
lng('🎲 ◦ Rock N Roll', '🎲 ◦ Rock N Roll', '🎲 ◦ Rock N Roll', '🎲 ◦ Rock N Roll'),
lng('🎲 ◦ Knight', '🎲 ◦ Knight', '🎲 ◦ Caballero', '🎲 ◦ Ksatria'),
lng('🎲 ◦ Wild West 2024', '🎲 ◦ Wild West 2024', '🎲 ◦ Lejano Oeste 2024', '🎲 ◦ Wild West 2024'),
lng('🎲 ◦ Birthday 2024', '🎲 ◦ Aniversário', '🎲 ◦ Cumpleaños', '🎲 ◦ Ulang Tahun 2024'),
lng('🎲 ◦ Egypt', '🎲 ◦ Egypt', '🎲 ◦ Egipto', '🎲 ◦ Mesir'),
lng('🎲 ◦ Masquerade', '🎲 ◦ Masquerade', '🎲 ◦ Masquerade', '🎲 ◦ Pesta Topeng'),
lng('🎲 ◦ Foras De Lã', '🎲 ◦ Baa Baa', '🎲 ◦ Masquerade', '🎲 ◦ Pesta Topeng'),
lng('🎲 ◦ Billy Bonka', '🎲 ◦ Billy Bonka', '🎲 ◦ Masquerade', '🎲 ◦ Pesta Topeng'),
lng('🎲 ◦ Festiva', '🎲 ◦ Festive', '🎲 ◦ Masquerade', '🎲 ◦ Pesta Topeng'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
     }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MNY == nil then return end
    if MNY == 1 then hack10() end
    if MNY == 2 then hack10b() end
    if MNY == 3 then hack10c() end
    if MNY == 4 then hack10d() end
    if MNY == 5 then hack10e() end
    if MNY == 6 then hack10f() end
    if MNY == 7 then hack10g() end
    if MNY == 8 then hack10h() end
    if MNY == 9 then hack10i() end
    if MNY == 10 then hack10j() end
    if MNY == 11 then hack10k() end
    if MNY == 12 then hack10l() end
    if MNY == 13 then hack10n() end
    if MNY == 14 then skinscp(13) end
    if MNY == 15 then skinscp(14) end
    if MNY == 16 then skinscp(15) end
    if MNY == 17 then menuescolhas(10) end

  elseif menu_tipo == 17 then
    MNR = gg.choice({
lng('🎲 ◦ Movie', '🎲 ◦ Movie', '🎲 ◦ Película', '🎲 ◦ Film'),
lng('🎲 ◦ Christmas 2022', '🎲 ◦ Christmas 2022', '🎲 ◦ Navidad 2022', '🎲 ◦ Natal 2022'),
lng('🎲 ◦ Valentine', '🎲 ◦ Valentine', '🎲 ◦ San Valentín', '🎲 ◦ Valentine'),
lng('🎲 ◦ Mars', '🎲 ◦ Mars', '🎲 ◦ Marte', '🎲 ◦ Mars'),
lng('🎲 ◦ Birthday', '🎲 ◦ Birthday', '🎲 ◦ Cumpleaños', '🎲 ◦ Ulang Tahun'),
lng('🎲 ◦ Sweet', '🎲 ◦ Sweet', '🎲 ◦ Dulce', '🎲 ◦ Manis'),
lng('🎲 ◦ Sweet 2', '🎲 ◦ Sweet 2', '🎲 ◦ Dulce 2', '🎲 ◦ Manis 2'),
lng('🎲 ◦ Halloween 2023', '🎲 ◦ Halloween 2023', '🎲 ◦ Halloween 2023', '🎲 ◦ Halloween 2023'),
lng('🎲 ◦ Winter Sport', '🎲 ◦ Winter Sport', '🎲 ◦ Deporte de Invierno', '🎲 ◦ Olahraga Musim Dingin'),
lng('🎲 ◦ CNY', '🎲 ◦ CNY', '🎲 ◦ CNY', '🎲 ◦ CNY'),
lng('🎲 ◦ Easter 2024', '🎲 ◦ Easter 2024', '🎲 ◦ Pascua 2024', '🎲 ◦ Paskah 2024'),
lng('🎲 ◦ Spy', '🎲 ◦ Spy', '🎲 ◦ Espía', '🎲 ◦ Mata-mata'),
lng('🎲 ◦ Atlantis', '🎲 ◦ Atlantis', '🎲 ◦ Atlántida', '🎲 ◦ Atlantis'),
lng('🎲 ◦ Italy 2024', '🎲 ◦ Italy 2024', '🎲 ◦ Italia 2024', '🎲 ◦ Italia 2024'),
lng('🎲 ◦ Birthday 2024', '🎲 ◦ Birthday 2024', '🎲 ◦ Cumpleaños 2024', '🎲 ◦ Ulang Tahun 2024'),
lng('🎲 ◦ Pirate 2024', '🎲 ◦ Pirate 2024', '🎲 ◦ Pirata 2024', '🎲 ◦ Bajak Laut 2024'),
lng('🎲 ◦ Arctic', '🎲 ◦ Arctic', '🎲 ◦ Arctic', '🎲 ◦ Arktik'),
lng('🎲 ◦ Classic', '🎲 ◦ Classic', '🎲 ◦ Classic', '🎲 ◦ Klasik'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
     }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MNR == nil then return end
    if MNR == 1 then hack9() end
    if MNR == 2 then hack9b() end
    if MNR == 3 then hack9c() end
    if MNR == 4 then hack9d() end
    if MNR == 5 then hack9e() end
    if MNR == 6 then hack9f() end
    if MNR == 7 then hack9g() end
    if MNR == 8 then hack9h() end
    if MNR == 9 then hack9i() end
    if MNR == 10 then hack9j() end
    if MNR == 11 then hack9k() end
    if MNR == 12 then hack9l() end
    if MNR == 13 then hack9m() end
    if MNR == 14 then hack9n() end
    if MNR == 15 then hack9o() end
    if MNR == 16 then hack9p() end
    if MNR == 17 then hack9q() end
    if MNR == 18 then hack9r() end
    if MNR == 19 then menuescolhas(10) end

  elseif menu_tipo == 18 then
    MNP = gg.choice({
lng('🎲 ◦ Expresso', '🎲 ◦ Express', '🎲 ◦ Expreso', '🎲 ◦ Ekspres'),
lng('🎲 ◦ Fantasma', '🎲 ◦ Ghost', '🎲 ◦ Fantasma', '🎲 ◦ Hantu'),
lng('🎲 ◦ Discoteca', '🎲 ◦ Disco', '🎲 ◦ Discoteca', '🎲 ◦ Disko'),
lng('🎲 ◦ Espacial', '🎲 ◦ Space', '🎲 ◦ Espacial', '🎲 ◦ Antariksa'),
lng('🎲 ◦ Vaqueiro', '🎲 ◦ Cowboy', '🎲 ◦ Vaquero', '🎲 ◦ Koboi'),
lng('🎲 ◦ Natal', '🎲 ◦ Christmas', '🎲 ◦ Navidad', '🎲 ◦ Natal'),
lng('🎲 ◦ Páscoa', '🎲 ◦ Easter', '🎲 ◦ Pascua', '🎲 ◦ Paskah'),
lng('🎲 ◦ Chinesa', '🎲 ◦ Chinese', '🎲 ◦ China', '🎲 ◦ Cina'),
lng('🎲 ◦ Antigo', '🎲 ◦ Ancient', '🎲 ◦ Antiguo', '🎲 ◦ Kuno'),
lng('🎲 ◦ Teatro', '🎲 ◦ Theater', '🎲 ◦ Teatro', '🎲 ◦ Teater'),
lng('🎲 ◦ Treinamento', '🎲 ◦ Training', '🎲 ◦ Entrenamiento', '🎲 ◦ Pelatihan'),
lng('🎲 ◦ Gravação', '🎲 ◦ Recording', '🎲 ◦ Grabación', '🎲 ◦ Rekaman'),
lng('🎲 ◦ Castelo', '🎲 ◦ Castle', '🎲 ◦ Castillo', '🎲 ◦ Kastil'),
lng('🎲 ◦ Romano', '🎲 ◦ Roman', '🎲 ◦ Romano', '🎲 ◦ Romawi'),
lng('🎲 ◦ Halloween', '🎲 ◦ Halloween', '🎲 ◦ Halloween', '🎲 ◦ Halloween'),
lng('🎲 ◦ Natal 2', '🎲 ◦ Christmas 2', '🎲 ◦ Navidad 2', '🎲 ◦ Natal 2'),

lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali') 
     }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))
    if MNP == nil then return end
    if MNP == 1 then hack002() end
    if MNP == 2 then hack002b() end
    if MNP == 3 then hack002c() end
    if MNP == 4 then hack002d() end
    if MNP == 5 then skinscp(1) end
    if MNP == 6 then skinscp(2) end
    if MNP == 7 then skinscp(3) end
    if MNP == 8 then skinscp(6) end
    if MNP == 9 then skinscp(4) end
    if MNP == 10 then skinscp(5) end
    if MNP == 11 then skinscp(7) end
    if MNP == 12 then skinscp(8) end
    if MNP == 13 then skinscp(9) end
    if MNP == 14 then skinscp(10) end
    if MNP == 15 then skinscp(11) end
    if MNP == 16 then skinscp(12) end
    if MNP == 17 then menuescolhas(10) end
    
  elseif menu_tipo == 19 then
    MN1 = gg.choice({
lng('🎲 ◦ Turbo', '🎲 ◦ Turbo', '🎲 ◦ Turbo', '🎲 ◦ Turbo'),
lng('🎲 ◦ Fantasma', '🎲 ◦ Ghost', '🎲 ◦ Fantasma', '🎲 ◦ Hantu'),
lng('🎲 ◦ Discoteca', '🎲 ◦ Disco', '🎲 ◦ Discoteca', '🎲 ◦ Disko'),
lng('🎲 ◦ Espacial', '🎲 ◦ Space', '🎲 ◦ Espacial', '🎲 ◦ Antariksa'),
lng('🎲 ◦ Vaqueiro', '🎲 ◦ Cowgirl', '🎲 ◦ Vaquera', '🎲 ◦ Gadis Koboi'),
lng('🎲 ◦ Natal', '🎲 ◦ Christmas', '🎲 ◦ Navidad', '🎲 ◦ Natal'),
lng('🎲 ◦ Páscoa', '🎲 ◦ Easter', '🎲 ◦ Pascua', '🎲 ◦ Paskah'),
lng('🎲 ◦ Chinesa', '🎲 ◦ Chinese', '🎲 ◦ China', '🎲 ◦ Cina'),
lng('🎲 ◦ Antigo', '🎲 ◦ Ancient', '🎲 ◦ Antiguo', '🎲 ◦ Kuno'),
lng('🎲 ◦ Teatro', '🎲 ◦ Theater', '🎲 ◦ Teatro', '🎲 ◦ Teater'),
lng('🎲 ◦ Treinamento', '🎲 ◦ Training', '🎲 ◦ Entrenamiento', '🎲 ◦ Pelatihan'),
lng('🎲 ◦ Gravação', '🎲 ◦ Recording', '🎲 ◦ Grabación', '🎲 ◦ Rekaman'),
lng('🎲 ◦ Castelo', '🎲 ◦ Castle', '🎲 ◦ Castillo', '🎲 ◦ Kastil'),
lng('🎲 ◦ Romano', '🎲 ◦ Roman', '🎲 ◦ Romano', '🎲 ◦ Romawi'),
lng('🎲 ◦ Halloween', '🎲 ◦ Halloween', '🎲 ◦ Halloween', '🎲 ◦ Halloween'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MN1 == nil then return end
    if MN1 == 1 then hack01() end
    if MN1 == 2 then hack01c() end
    if MN1 == 3 then hack01d() end
    if MN1 == 4 then hack01e9() end
    if MN1 == 5 then hack01b() end
    if MN1 == 6 then hack01ee() end
    if MN1 == 7 then hack01e2() end
    if MN1 == 8 then hack01e3() end
    if MN1 == 9 then hack01e4() end
    if MN1 == 10 then hack01e5() end
    if MN1 == 11 then hack01e6() end
    if MN1 == 12 then hack01e8() end
    if MN1 == 13 then hack01e7() end
    if MN1 == 14 then hack01e() end
    if MN1 == 15 then hackskn(6) end
    if MN1 == 16 then menuescolhas(10) end

  elseif menu_tipo == 188 then -- Helipad
    MTP = gg.choice({
lng('🎲 ◦ Voador', '🎲 ◦ Flying', '🎲 ◦ Volador', '🎲 ◦ Terbang'),
lng('🎲 ◦ Ancoragem', '🎲 ◦ Anchoring', '🎲 ◦ Anclaje', '🎲 ◦ Jangkar'),
lng('🎲 ◦ Trenó', '🎲 ◦ Sleigh', '🎲 ◦ Trineo', '🎲 ◦ Kereta Luncur'),
lng('🎲 ◦ Privado', '🎲 ◦ Private', '🎲 ◦ Privado', '🎲 ◦ Pribadi'),
lng('🎲 ◦ Vegetal', '🎲 ◦ Vegetable', '🎲 ◦ Vegetal', '🎲 ◦ Sayuran'),
lng('🎲 ◦ Sultão', '🎲 ◦ Sultan', '🎲 ◦ Sultán', '🎲 ◦ Sultan'),
lng('🎲 ◦ Estrelas', '🎲 ◦ Stars', '🎲 ◦ Estrellas', '🎲 ◦ Bintang'),
lng('🎲 ◦ Viajante', '🎲 ◦ Traveler', '🎲 ◦ Viajero', '🎲 ◦ Pengelana'),
lng('🎲 ◦ Esportivo', '🎲 ◦ Sporty', '🎲 ◦ Deportivo', '🎲 ◦ Sportif'),
lng('🎲 ◦ Real', '🎲 ◦ Royal', '🎲 ◦ Real', '🎲 ◦ Kerajaan'),
lng('🎲 ◦ Assombrado', '🎲 ◦ Haunted', '🎲 ◦ Embrujado', '🎲 ◦ Berhantu'),
lng('🎲 ◦ Carnavalesca', '🎲 ◦ Carnival', '🎲 ◦ Carnavalesca', '🎲 ◦ Karnaval'),
lng('🎲 ◦ Páscoa', '🎲 ◦ Easter', '🎲 ◦ Pascua', '🎲 ◦ Paskah'),
lng('🎲 ◦ Subaquático', '🎲 ◦ Underwater', '🎲 ◦ Subacuático', '🎲 ◦ Bawah Air'),
lng('🎲 ◦ Pirata', '🎲 ◦ Pirate', '🎲 ◦ Pirata', '🎲 ◦ Bajak Laut'),
lng('🎲 ◦ Festivo', '🎲 ◦ Festive', '🎲 ◦ Festivo', '🎲 ◦ Meriah'),
lng('🎲 ◦ Baile', '🎲 ◦ Ball', '🎲 ◦ Baile', '🎲 ◦ Dansa'),
lng('🎲 ◦ Investigação', '🎲 ◦ Investigation', '🎲 ◦ Investigación', '🎲 ◦ Investigasi'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')

    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MTP == nil then return end
    if MTP == 1 then skinscp(31) end
    if MTP == 2 then skinscp(32) end
    if MTP == 3 then skinscp(33) end
    if MTP == 4 then skinscp(34) end
    if MTP == 5 then skinscp(35) end
    if MTP == 6 then skinscp(36) end
    if MTP == 7 then skinscp(37) end
    if MTP == 8 then skinscp(39) end
    if MTP == 9 then skinscp(40) end
    if MTP == 10 then skinscp(41) end
    if MTP == 11 then skinscp(42) end
    if MTP == 12 then skinscp(43) end
    if MTP == 13 then skinscp(44) end
    if MTP == 14 then skinscp(45) end
    if MTP == 15 then skinscp(46) end
    if MTP == 16 then skinscp(47) end
    if MTP == 17 then skinscp(48) end
    if MTP == 18 then skinscp(38) end
    if MTP == 19 then menuescolhas(10) end

  elseif menu_tipo == 199 then -- Helicopter
    MG1 = gg.choice({
lng('🎲 ◦ Turbo', '🎲 ◦ Turbo', '🎲 ◦ Turbo', '🎲 ◦ Turbo'),
lng('🎲 ◦ Entregador', '🎲 ◦ Delivery', '🎲 ◦ Repartidor', '🎲 ◦ Kurir'),
lng('🎲 ◦ Natal', '🎲 ◦ Christmas', '🎲 ◦ Navidad', '🎲 ◦ Natal'),
lng('🎲 ◦ Privado', '🎲 ◦ Private', '🎲 ◦ Privado', '🎲 ◦ Pribadi'),
lng('🎲 ◦ Berinjela', '🎲 ◦ Eggplant', '🎲 ◦ Berenjena', '🎲 ◦ Terong'),
lng('🎲 ◦ Tepete', '🎲 ◦ Tepete', '🎲 ◦ Tepete', '🎲 ◦ Tepete'),
lng('🎲 ◦ Espreguiçadeira', '🎲 ◦ Lounge Chair', '🎲 ◦ Tumbona', '🎲 ◦ Kursi Santai'),
lng('🎲 ◦ Navio Voador', '🎲 ◦ Flying Ship', '🎲 ◦ Barco Volador', '🎲 ◦ Kapal Terbang'),
lng('🎲 ◦ Folia', '🎲 ◦ Revelry', '🎲 ◦ Festejo', '🎲 ◦ Pesta'),
lng('🎲 ◦ Vigilância', '🎲 ◦ Surveillance', '🎲 ◦ Vigilancia', '🎲 ◦ Pengawasan'),
lng('🎲 ◦ Caldeirão', '🎲 ◦ Cauldron', '🎲 ◦ Caldero', '🎲 ◦ Kuali'),
lng('🎲 ◦ Oval', '🎲 ◦ Oval', '🎲 ◦ Ovalado', '🎲 ◦ Oval'),
lng('🎲 ◦ Batiscafo', '🎲 ◦ Bathyscaphe', '🎲 ◦ Batiscafo', '🎲 ◦ Batiskaf'),
lng('🎲 ◦ Festivo', '🎲 ◦ Festive', '🎲 ◦ Festivo', '🎲 ◦ Meriah'),
lng('🎲 ◦ Baile', '🎲 ◦ Ball', '🎲 ◦ Baile', '🎲 ◦ Pesta Dansa'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MG1 == nil then return end
    if MG1 == 1 then hackh1() end
    if MG1 == 2 then hackh2() end
    if MG1 == 3 then hackh3() end
    if MG1 == 4 then hackh4() end
    if MG1 == 5 then hackh5() end
    if MG1 == 6 then hackh6() end
    if MG1 == 7 then hackh7() end
    if MG1 == 8 then hackh8() end
    if MG1 == 9 then hackh9() end
    if MG1 == 10 then skinscp(49) end
    if MG1 == 11 then skinscp(50) end
    if MG1 == 12 then skinscp(51) end
    if MG1 == 13 then skinscp(52) end
    if MG1 == 14 then skinscp(53) end
    if MG1 == 15 then skinscp(54) end
    if MG1 == 16 then menuescolhas(10) end

  elseif menu_tipo == 20 then
    MN2 = gg.choice({
lng('🎲 ◦ Choupana Pirata', '🎲 ◦ Pirate Hut', '🎲 ◦ Cabaña Pirata', '🎲 ◦ Gubuk Bajak Laut'),
lng('🎲 ◦ Cabana Pirata', '🎲 ◦ Pirate Cabin', '🎲 ◦ Cabaña Pirata', '🎲 ◦ Kabin Bajak Laut'),
lng('🎲 ◦ Vila De Pàscoa', '🎲 ◦ Easter Village', '🎲 ◦ Pueblo de Pascua', '🎲 ◦ Desa Paskah'),
lng('🎲 ◦ Residência Da Ilha', '🎲 ◦ Island Residence', '🎲 ◦ Residencia de la Isla', '🎲 ◦ Rumah Pulau'),
lng('🎲 ◦ Mansão Da Ilha', '🎲 ◦ Island Mansion', '🎲 ◦ Mansión de la Isla', '🎲 ◦ Mansion Pulau'),
lng('🎲 ◦ Paris', '🎲 ◦ Paris', '🎲 ◦ París', '🎲 ◦ Paris'),
lng('🎲 ◦ Natal', '🎲 ◦ Christmas', '🎲 ◦ Navidad', '🎲 ◦ Natal'),
lng('🎲 ◦ Casa Bruxa', '🎲 ◦ Witch House', '🎲 ◦ Casa de Bruja', '🎲 ◦ Rumah Penyihir'),
lng('🎲 ◦ Mansão Bruxa', '🎲 ◦ Witch Mansion', '🎲 ◦ Mansión de Bruja', '🎲 ◦ Istana Penyihir'),
lng('🎲 ◦ Castelo Bruxa', '🎲 ◦ Witch Castle', '🎲 ◦ Castillo de Bruja', '🎲 ◦ Kastil Penyihir'),
lng('🎲 ◦ Gelo', '🎲 ◦ Ice', '🀀󼠠◦ Hielo', '🎲 ◦ Es'),
lng('🎲 ◦ Neandertal', '🎲 ◦ Neanderthal', '🎲 ◦ Neandertal', '🎲 ◦ Neanderthal'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MN2 == nil then return end
    if MN2 == 1 then hack02() end
    if MN2 == 2 then hack02c() end
    if MN2 == 3 then hack02b() end
    if MN2 == 4 then hack02d() end
    if MN2 == 5 then hack02e() end
    if MN2 == 6 then hack02f() end
    if MN2 == 7 then hack02g() end
    if MN2 == 8 then skinscp(23) end
    if MN2 == 9 then skinscp(24) end
    if MN2 == 10 then skinscp(25) end
    if MN2 == 11 then skinscp(26) end
    if MN2 == 12 then skinscp(27) end
    if MN2 == 13 then menuescolhas(10) end

  elseif menu_tipo == 21 then
    MN3 = gg.choice({
lng('🎲 ◦ Natal', '🎲 ◦ Christmas', '🎲 ◦ Navidad', '🎲 ◦ Natal'),
lng('🎲 ◦ Haloween', '🎲 ◦ Halloween', '🎲 ◦ Halloween', '🎲 ◦ Halloween'),
lng('🎲 ◦ Namorados/Amizade', '🎲 ◦ Valentine/Friendship', '🎲 ◦ San Valentín/Amistad', '🎲 ◦ Valentine/Persahabatan'),
lng('🎲 ◦ Árvores', '🎲 ◦ Trees', '🎲 ◦ Árboles', '🎲 ◦ Pohon'),
lng('🎲 ◦ Gelo', '🎲 ◦ Ice', '🎲 ◦ Hielo', '🎲 ◦ Es'),
lng('🎲 ◦ Pontes/Cercas', '🎲 ◦ Bridges/Fences', '🎲 ◦ Puentes/Cercas', '🎲 ◦ Jembatan/Pagar'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MN3 == nil then return end
    if MN3 == 1 then menuescolhas(22) end
    if MN3 == 2 then menuescolhas(222) end
    if MN3 == 3 then menuescolhas(23) end
    if MN3 == 4 then menuescolhas(233) end
    if MN3 == 5 then menuescolhas(244) end
    if MN3 == 6 then menuescolhas(255) end
    if MN3 == 7 then menuescolhas(4) end

  elseif menu_tipo == 22 then
    MN4 = gg.choice({
lng('🎲 ◦ Boneco De Neve', '🎲 ◦ Snowman', '🎲 ◦ Muñeco de Nieve', '🎲 ◦ Manusia Salju'),
lng('🎲 ◦ Loja De Artigos', '🎲 ◦ Goods Store', '🎲 ◦ Tienda de Artículos', '🎲 ◦ Toko Barang'),
lng('🎲 ◦ Natal Sobre Rodas', '🎲 ◦ Christmas On Wheels', '🎲 ◦ Navidad Sobre Ruedas', '🎲 ◦ Natal Beroda'),
lng('🎲 ◦ Mercado De Árvore', '🎲 ◦ Tree Market', '🎲 ◦ Mercado de Árboles', '🎲 ◦ Pasar Pohon'),
lng('🎲 ◦ Loja De Lembrancinha', '🎲 ◦ Souvenir Shop', '🎲 ◦ Tienda de Recuerdos', '🎲 ◦ Toko Oleh-Oleh'),
lng('🎲 ◦ Ponte Do Casal', '🎲 ◦ Couple Bridge', '🎲 ◦ Puente de la Pareja', '🎲 ◦ Jembatan Pasangan'),
lng('🎲 ◦ Número Mágico', '🎲 ◦ Magic Number', '🎲 ◦ Número Mágico', '🎲 ◦ Nomor Ajaib'),
lng('🎲 ◦ Casa Do Duende', '🎲 ◦ Elf House', '🎲 ◦ Casa del Duende', '🎲 ◦ Rumah Elf'),
lng('🎲 ◦ Casa De Neve', '🎲 ◦ Snow House', '🎲 ◦ Casa de Nieve', '🎲 ◦ Rumah Salju'),
lng('🎲 ◦ Globo De Neve', '🎲 ◦ Snow Globe', '🎲 ◦ Bola de Nieve', '🎲 ◦ Bola Salju'),
lng('🎲 ◦ Casa Do Papai Noel', '🎲 ◦ Santa House', '🎲 ◦ Casa de Santa Claus', '🎲 ◦ Rumah Santa'),
lng('🎲 ◦ Cabana Dos Presentes', '🎲 ◦ Presents Cabin', '🎲 ◦ Cabaña de Regalos', '🎲 ◦ Kabin Hadiah'),
lng('🎲 ◦ Iglu De Neve', '🎲 ◦ Snowman Igloo', '🎲 ◦ Iglú de Nieve', '🎲 ◦ Igloo Salju'),
lng('🎲 ◦ Meia De Natal', '🎲 ◦ Christmas Stocking', '🎲 ◦ Media de Navidad', '🎲 ◦ Stoking Natal'),
lng('🎲 ◦ Guerra De Neve', '🎲 ◦ Snowball Fight', '🎲 ◦ Batalla de Nieve', '🎲 ◦ Perang Bola Salju'),
lng('🎲 ◦ Trenó Turbinado', '🎲 ◦ Turbo Sleigh', '🎲 ◦ Trineo Turbo', '🎲 ◦ Kereta Luncur Turbo'),
lng('🎲 ◦ Trenó De Cães', '🎲 ◦ Dog Sled', '🎲 ◦ Trineo de Perros', '🎲 ◦ Kereta Anjing'),
lng('🎲 ◦ Festividades', '🎲 ◦ Festivities', '🎲 ◦ Festividades', '🎲 ◦ Perayaan'),
lng('🎲 ◦ Ajudante Noel', '🎲 ◦ Santa Helper', '🎲 ◦ Ayudante de Santa', '🎲 ◦ Pembantu Santa'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MN4 == nil then return end
    if MN4 == 1 then hackd(12) end
    if MN4 == 2 then hackd(13) end
    if MN4 == 3 then hackd(14) end
    if MN4 == 4 then hackd(15) end
    if MN4 == 5 then hackd(16) end
    if MN4 == 6 then hackd(17) end
    if MN4 == 7 then hackd(18) end
    if MN4 == 8 then hackd(19) end
    if MN4 == 9 then hackd(20) end
    if MN4 == 10 then hackd(21) end
    if MN4 == 11 then hackd(22) end
    if MN4 == 12 then hackd(23) end
    if MN4 == 13 then hackd(24) end
    if MN4 == 14 then hackd(25) end
    if MN4 == 15 then hackd(26) end
    if MN4 == 16 then hackd(27) end
    if MN4 == 17 then hackd(28) end
    if MN4 == 18 then hackd(29) end
    if MN4 == 19 then hackd(30) end
    if MN4 == 20 then menuescolhas(21) end

  elseif menu_tipo == 222 then
    MN7 = gg.choice({
lng('🎲 ◦ Estacionamento Bruxas', '🎲 ◦ Witches Parking', '🎲 ◦ Estacionamiento de Brujas', '🎲 ◦ Tempat Parkir Penyihir'),
lng('🎲 ◦ Castelo Misterioso', '🎲 ◦ Mysterious Castle', '🎲 ◦ Castillo Misterioso', '🎲 ◦ Kastil Misterius'),
lng('🎲 ◦ Horta Supernatural', '🎲 ◦ Supernatural Garden', '🎲 ◦ Jardín Sobrenatural', '🎲 ◦ Kebun Supranatural'),
lng('🎲 ◦ Caldeirão Mágico', '🎲 ◦ Magic Cauldron', '🎲 ◦ Caldero Mágico', '🎲 ◦ Kuali Ajaib'),
lng('🎲 ◦ Bruxa De Vassoura', '🎲 ◦ Witch Broomstick', '🎲 ◦ Bruja de Escoba', '🎲 ◦ Sapu Penyihir'),
lng('🎲 ◦ Fonte Sinistra', '🎲 ◦ Sinister Fountain', '🎲 ◦ Fuente Sinistra', '🎲 ◦ Air Mancur Mengerikan'),
lng('🎲 ◦ Espantalho De Abóbora', '🎲 ◦ Pumpkin Scarecrow', '🎲 ◦ Espantapájaros de Calabaza', '🎲 ◦ Orang-orangan Sawah Labu'),
lng('🎲 ◦ Árvore Com Abóboras', '🎲 ◦ Tree With Pumpkins', '🎲 ◦ Árbol con Calabazas', '🎲 ◦ Pohon Dengan Labu'),
lng('🎲 ◦ Casa Dos Horrores', '🎲 ◦ House Of Horrors', '🎲 ◦ Casa de los Horrores', '🎲 ◦ Rumah Horor'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MN7 == nil then return end
    if MN7 == 1 then hackd(32) end
    if MN7 == 2 then hackd(33) end
    if MN7 == 3 then hackd(34) end
    if MN7 == 4 then hackd(35) end
    if MN7 == 5 then hackd(36) end
    if MN7 == 6 then hackd(37) end
    if MN7 == 7 then hackd(38) end
    if MN7 == 8 then hackd(39) end
    if MN7 == 9 then hackd(40) end
    if MN7 == 10 then menuescolhas(21) end

  elseif menu_tipo == 23 then
    MN5 = gg.choice({
lng('🎲 ◦ Piquenique De Gala', '🎲 ◦ Gala Picnic', '🎲 ◦ Picnic de Gala', '🎲 ◦ Piknik Gala'),
lng('🎲 ◦ Piloto Apaixonado', '🎲 ◦ Passionate Pilot', '🎲 ◦ Piloto Apasionado', '🎲 ◦ Pilot Penuh Gairah'),
lng('🎲 ◦ Serenata Sem Fim', '🎲 ◦ Endless Serenade', '🎲 ◦ Serenata Eterna', '🎲 ◦ Serenade Tak Berujung'),
lng('🎲 ◦ Encontro Duplo', '🎲 ◦ Double Date', '🎲 ◦ Cita Doble', '🎲 ◦ Kencan Ganda'),
lng('🎲 ◦ Ninho Familiar', '🎲 ◦ Family Nest', '🎲 ◦ Nido Familiar', '🎲 ◦ Sarang Keluarga'),
lng('🎲 ◦ Recém Casados', '🎲 ◦ Just Married', '🎲 ◦ Recién Casados', '🎲 ◦ Pasangan Baru'),
lng('🎲 ◦ Encontro Romântico', '🎲 ◦ Romantic Date', '🎲 ◦ Cita Romántica', '🎲 ◦ Kencan Romantis'),
lng('🎲 ◦ Ursinho Apaixonado', '🎲 ◦ Romantic Teddy', '🎲 ◦ Osito Romántico', '🎲 ◦ Boneka Beruang Romantis'),
lng('🎲 ◦ Ursinho De Pelúcia', '🎲 ◦ Teddy Bear', '🎲 ◦ Osito de Peluche', '🎲 ◦ Boneka Beruang'),
lng('🎲 ◦ Canteiro Angelical', '🀀󼠠◦ Angelic Garden', '🎲 ◦ Jardín Angelical', '🎲 ◦ Taman Malaikat'),
lng('🎲 ◦ Poste De Flores', '🎲 ◦ Flower Post', '🎲 ◦ Poste de Flores', '🎲 ◦ Tiang Bunga'),
lng('🎲 ◦ Amor Eterno', '🎲 ◦ Eternal Love', '🎲 ◦ Amor Eterno', '🎲 ◦ Cinta Abadi'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MN5 == nil then return end
    if MN5 == 1 then hackd(0) end
    if MN5 == 2 then hackd(1) end
    if MN5 == 3 then hackd(2) end
    if MN5 == 4 then hackd(3) end
    if MN5 == 5 then hackd(4) end
    if MN5 == 6 then hackd(5) end
    if MN5 == 7 then hackd(6) end
    if MN5 == 8 then hackd(7) end
    if MN5 == 9 then hackd(8) end
    if MN5 == 10 then hackd(9) end
    if MN5 == 11 then hackd(10) end
    if MN5 == 12 then hackd(11) end
    if MN5 == 13 then menuescolhas(21) end

  elseif menu_tipo == 233 then
    MN8 = gg.choice({
lng('🎲 ◦ Rosa Do Deserto', '🎲 ◦ Desert Rose', '🎲 ◦ Rosa del Desierto', '🎲 ◦ Mawar Gurun'),
lng('🎲 ◦ Acácia', '🎲 ◦ Acacia', '🎲 ◦ Acacia', '🎲 ◦ Akasia'),
lng('🎲 ◦ Ipê Amarelo', '🎲 ◦ Yellow Ipe', '🎲 ◦ Ipe Amarillo', '🎲 ◦ Ipê Kuning'),
lng('🎲 ◦ Flamboiã', '🎲 ◦ Flamboyant', '🎲 ◦ Flamboyán', '🎲 ◦ Flamboyan'),
lng('🎲 ◦ Baoba', '🎲 ◦ Baobab', '🎲 ◦ Baobab', '🎲 ◦ Baobab'),
lng('🎲 ◦ Festiva', '🎲 ◦ Festive', '🎲 ◦ Festiva', '🎲 ◦ Meriah'),
lng('🎲 ◦ Glicínia', '🎲 ◦ Wisteria', '🎲 ◦ Glicinia', '🎲 ◦ Wisteria'),
lng('🎲 ◦ Palmeira', '🎲 ◦ Palm Tree', '🎲 ◦ Palma', '🎲 ◦ Pohon Palem'),
lng('🎲 ◦ Doce', '🎲 ◦ Sweet', '🎲 ◦ Dulce', '🎲 ◦ Manis'),
lng('🎲 ◦ Sakura', '🎲 ◦ Sakura', '🎲 ◦ Sakura', '🎲 ◦ Sakura'),
lng('🎲 ◦ Pinha Japonesa', '🎲 ◦ Japanese Pinecone', '🎲 ◦ Piña Japonesa', '🎲 ◦ Kerucut Pinus Jepang'),
lng('🎲 ◦ Cacto', '🎲 ◦ Cactus', '🎲 ◦ Cactus', '🎲 ◦ Kaktus'),
lng('🎲 ◦ Macieira', '🎲 ◦ Apple Tree', '🎲 ◦ Manzano', '🎲 ◦ Pohon Apel'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if MN8 == nil then return end
    if MN8 == 1 then hackd(41) end
    if MN8 == 2 then hackd(42) end
    if MN8 == 3 then hackd(43) end
    if MN8 == 4 then hackd(44) end
    if MN8 == 5 then hackd(45) end
    if MN8 == 6 then hackd(46) end
    if MN8 == 7 then hackd(47) end
    if MN8 == 8 then hackd(48) end
    if MN8 == 9 then hackd(49) end
    if MN8 == 10 then hackd(50) end
    if MN8 == 11 then hackd(51) end
    if MN8 == 12 then hackd(52) end
    if MN8 == 13 then hackd(53) end
    if MN8 == 14 then menuescolhas(21) end

  elseif menu_tipo == 244 then
    FTg = gg.choice({
lng('🎲 ◦ Casa Do Lago', '🎲 ◦ Lakeside House', '🎲 ◦ Casa del Lago', '🎲 ◦ Rumah Tepi Danau'),
lng('🎲 ◦ Estação Polar', '🎲 ◦ Polar Station', '🎲 ◦ Estación Polar', '🎲 ◦ Stasiun Polar'),
lng('🎲 ◦ Castelo De Gelo', '🎲 ◦ Ice Castle', '🎲 ◦ Castillo de Hielo', '🎲 ◦ Kastil Es'),
lng('🎲 ◦ Museu De Gelo', '🎲 ◦ Ice Museum', '🎲 ◦ Museo de Hielo', '🎲 ◦ Museum Es'),
lng('🎲 ◦ Portão De Gelo', '🎲 ◦ Ice Gate', '🎲 ◦ Puerta de Hielo', '🎲 ◦ Gerbang Es'),
lng('🎲 ◦ Guerra De Neve', '🎲 ◦ Snow War', '🎲 ◦ Guerra de Nieve', '🎲 ◦ Perang Salju'),
lng('🎲 ◦ Explorador Polar', '🎲 ◦ Polar Explorer', '🎲 ◦ Explorador Polar', '🎲 ◦ Penjelajah Kutub'),
lng('🎲 ◦ Pista De Patinação', '🎲 ◦ Ice Skating Rink', '🎲 ◦ Pista de Patinaje', '🎲 ◦ Arena Seluncur Es'),
lng('🎲 ◦ Escultura De Gelo', '🎲 ◦ Ice Sculpture', '🎲 ◦ Escultura de Hielo', '🎲 ◦ Patung Es'),
lng('🎲 ◦ Escorregador Castelo', '🎲 ◦ Castle Slide', '🎲 ◦ Resbaladilla de Castillo', '🎲 ◦ Perosotan Kastil'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if FTg == nil then return end
    if FTg == 1 then hackd(63) end
    if FTg == 2 then hackd(64) end
    if FTg == 3 then hackd(65) end
    if FTg == 4 then hackd(66) end
    if FTg == 5 then hackd(67) end
    if FTg == 6 then hackd(68) end
    if FTg == 7 then hackd(69) end
    if FTg == 8 then hackd(70) end
    if FTg == 9 then hackd(71) end
    if FTg == 10 then hackd(72) end
    if FTg == 11 then menuescolhas(21) end

  elseif menu_tipo == 24 then
    FTf = gg.choice({
lng('🎲 ◦ Conquistas Aniversário', '🎲 ◦ Anniversary Achievements', '🎲 ◦ Logros Aniversario', '🎲 ◦ Prestasi Ulang Tahun'),
lng('🎲 ◦ Conquistas Completas', '🎲 ◦ Complete Achievements', '🎲 ◦ Completar Logros', '🎲 ◦ Prestasi Lengkap'),
lng('🎲 ◦ Participação Eventos (2024)', '🎲 ◦ Event Participation (2024)', '🎲 ◦ Eventos Participación (2024)', '🎲 ◦ Partisipasi Acara (2024)'),
lng('🎲 ◦ Participação Eventos (2023)', '🎲 ◦ Event Participation (2023)', '🎲 ◦ Eventos Participación (2023)', '🎲 ◦ Partisipasi Acara (2023)'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if FTf == nil then return end
    if FTf == 1 then menuescolhas(243) end
    if FTf == 2 then menuescolhas(247) end
    if FTf == 3 then menuescolhas(245) end
    if FTf == 4 then menuescolhas(246) end
    if FTf == 5 then menuescolhas(4) end

  elseif menu_tipo == 243 then
    FTFc = gg.choice({
lng('🎲 ◦ 1 Ano', '🎲 ◦ 1 Year', '🎲 ◦ 1 Años', '🎲 ◦ 1 Tahun'),
lng('🎲 ◦ 2 Anos', '🎲 ◦ 2 Years', '🎲 ◦ 2 Años', '🎲 ◦ 2 Tahun'),
lng('🎲 ◦ 3 Anos', '🎲 ◦ 3 Years', '🎲 ◦ 3 Años', '🎲 ◦ 3 Tahun'),
lng('🎲 ◦ 4 Anos', '🎲 ◦ 4 Years', '🎲 ◦ 4 Años', '🎲 ◦ 4 Tahun'),
lng('🎲 ◦ 5 Anos', '🎲 ◦ 5 Years', '🎲 ◦ 5 Años', '🎲 ◦ 5 Tahun'),
lng('🎲 ◦ 7 Anos', '🎲 ◦ 7 Years', '🎲 ◦ 7 Años', '🎲 ◦ 7 Tahun'),
lng('🎲 ◦ 8 Anos', '🎲 ◦ 8 Years', '🎲 ◦ 8 Años', '🎲 ◦ 8 Tahun'),
lng('🎲 ◦ 9 Anos', '🎲 ◦ 9 Years', '🎲 ◦ 9 Años', '🎲 ◦ 9 Tahun'),
lng('🎲 ◦ 10 Anos', '🎲 ◦ 10 Years', '🎲 ◦ 10 Años', '🎲 ◦ 10 Tahun'),
lng('🎲 ◦ Comemore 11 Anos', '🎲 ◦ Celebrate 11-Year', '🎲 ◦ Celebra 11 Años', '🎲 ◦ Rayakan 11 Tahun'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if FTFc == nil then return end
    if FTFc == 1 then hack_photo(31, 1) end
    if FTFc == 2 then hack_photo(32, 1) end
    if FTFc == 3 then hack_photo(33, 1) end
    if FTFc == 4 then hack_photo(34, 1) end
    if FTFc == 5 then hack_photo(35, 1) end
    if FTFc == 6 then hack_photo(36, 1) end
    if FTFc == 7 then hack_photo(37, 1) end
    if FTFc == 8 then hack_photo(38, 1) end
    if FTFc == 9 then hack_photo(39, 1) end
    if FTFc == 10 then hack_photo(40, 1) end
    if FTFc == 11 then menuescolhas(24) end

  elseif menu_tipo == 245 then
    FT = gg.choice({
lng('🎲 ◦ Coração Shambala', '🎲 ◦ Heart Shambala', '🎲 ◦ Corazón Shambala', '🎲 ◦ Hati Shambala'), 
lng('🎲 ◦ Aventura Infinita', '🎲 ◦ Infinite Adventure', '🎲 ◦ Aventura Infinita', '🎲 ◦ Petualangan Tak Berujung'),
lng('🎲 ◦ Evento de Carnaval Brasileiro', '🎲 ◦ Brazilian Carnival Event', '🎲 ◦ Evento de Carnaval Brasileño', '🎲 ◦ Acara Karnaval Brasil'), 
lng('🎲 ◦ Lendas da Grécia', '🎲 ◦ Legends of Greece Event', '🎲 ◦ Leyendas de Grecia', '🎲 ◦ Legenda Yunani'), 
lng('🎲 ◦ Aventura Lendária', '🎲 ◦ Legendary Adventure', '🎲 ◦ Aventura Legendaria', '🎲 ◦ Petualangan Legendaris'), 
lng('🎲 ◦ Festival das Lanternas', '🎲 ◦ Lantern Festival', '🎲 ◦ Festival de Faroles', '🎲 ◦ Festival Lentera'),
lng('🎲 ◦ Festa Retrô', '🎲 ◦ Retro Party', '🎲 ◦ Fiesta Retro', '🎲 ◦ Pesta Retro'),
lng('🎲 ◦ Jornada Irlandesa', '🎲 ◦ Irish Journey', '🎲 ◦ Viaje Irlandés', '🎲 ◦ Perjalanan Irlandia'), 
lng('🎲 ◦ Aventura de Páscoa', '🎲 ◦ Easter Adventure', '🎲 ◦ Aventura de Pascua', '🎲 ◦ Petualangan Paskah'), 
lng('🎲 ◦ Feira de Artesanato', '🎲 ◦ Craft Fair', '🎲 ◦ Feria de Artesanía', '🎲 ◦ Pameran Kerajinan'), 
lng('🎲 ◦ Festival de Rock', '🎲 ◦ Rock Roll Festival', '🎲 ◦ Festival de Rock', '🎲 ◦ Festival Rock'), 
lng('🎲 ◦ Evento de Acampamento', '🎲 ◦ Camping Trip Event', '🎲 ◦ Evento de Campamento', '🎲 ◦ Acara Berkemah'), 
lng('🎲 ◦ Terra das Vespas', '🎲 ◦ Land of Wasps', '🎲 ◦ Tierra de Avispas', '🎲 ◦ Tanah Tawon'),
lng('🎲 ◦ Mundo Antigo', '🎲 ◦ Ancient World', '🎲 ◦ Mundo Antiguo', '🎲 ◦ Dunia Kuno'), 
lng('🎲 ◦ Festival de Praia', '🎲 ◦ Beach Festival Event', '🎲 ◦ Festival de Playa', '🎲 ◦ Festival Pantai'), 
lng('🎲 ◦ Jogos de Espionagem', '🎲 ◦ Spy Games Event', '🎲 ◦ Juegos de Espionaje', '🎲 ◦ Permainan Mata-mata'), 
lng('🎲 ◦ Preso no País das Maravilhas', '🎲 ◦ Trapped in Wonderland', '🎲 ◦ Atrapado en el País de las Maravillas', '🎲 ◦ Terjebak di Negeri Ajaib'),
lng('🎲 ◦ Aventura Lendária 2', '🎲 ◦ Legendary Adventure 2', '🎲 ◦ Aventura Legendaria 2', '🎲 ◦ Petualangan Legendaris 2'), 
lng('🎲 ◦ Investigação da Base Secreta', '🎲 ◦ Secret Base Investigation', '🎲 ◦ Investigación de la Base Secreta', '🎲 ◦ Penyelidikan Pangkalan Rahasia'),
lng('🎲 ◦ Aventura Lendária 3', '🎲 ◦ Legendary Adventure 3', '🎲 ◦ Aventura Legendaria 3', '🎲 ◦ Petualangan Legendaris 3'), 
lng('🎲 ◦ Sabor da Itália', '🎲 ◦ Taste of Italy', '🎲 ◦ Sabor de Italia', '🎲 ◦ Rasa Italia'), 
lng('🎲 ◦ Irmandade dos Cavaleiros', '🎲 ◦ Brotherhood of the Knights', '🎲 ◦ Hermandad de los Caballeros', '🎲 ◦ Persaudaraan Ksatria'), 
lng('🎲 ◦ Pico do Aventureiro', '🎲 ◦ Adventurer\'s Peak', '🎲 ◦ Pico del Aventurero', '🎲 ◦ Puncak Petualang'), 
lng('🎲 ◦ Tesouros de Atlântida', '🎲 ◦ Treasures of Atlantis', '🎲 ◦ Tesoros de la Atlántida', '🎲 ◦ Harta Atlantis'),
lng('🎲 ◦ Jogo de Sobrevivência', '🎲 ◦ Survival Game', '🎲 ◦ Juego de Supervivencia', '🎲 ◦ Permainan Bertahan Hidup'), 
lng('🎲 ◦ Aventura Lendária 4', '🎲 ◦ Legendary Adventure 4', '🎲 ◦ Aventura Legendaria 4', '🎲 ◦ Petualangan Legendaris 4'), 
lng('🎲 ◦ Aventura Lendária 5', '🎲 ◦ Legendary Adventure 5', '🎲 ◦ Aventura Legendaria 5', '🎲 ◦ Petualangan Legendaris 5'), 
lng('🎲 ◦ Velho Oeste Selvagem', '🎲 ◦ Wild Wild West', '🎲 ◦ Salvaje Oeste', '🎲 ◦ Barat Liar'), 
lng('🎲 ◦ Férias na Praia', '🎲 ◦ Beach Vacation', '🎲 ◦ Vacaciones en la Playa', '🎲 ◦ Liburan Pantai'), 
lng('🎲 ◦ Segredos da Área 551', '🎲 ◦ Secrets of Area 551', '🎲 ◦ Secretos del Área 551', '🎲 ◦ Rahasia Area 551'), 
lng('🎲 ◦ Férias Italianas 2', '🎲 ◦ Italian Holiday 2', '🀀󼠠◦ Vacaciones Italianas 2', '🎲 ◦ Liburan Italia 2'), 
lng('🎲 ◦ Expedição na Caverna', '🎲 ◦ Cave Expedition Event', '🎲 ◦ Expedición a la Cueva', '🎲 ◦ Ekspedisi Gua'), 
lng('🎲 ◦ Aventura Lendária 6', '🎲 ◦ Legendary Adventure 6', '🎲 ◦ Aventura Legendaria 6', '🎲 ◦ Petualangan Legendaris 6'), 
lng('🎲 ◦ Evento de Aniversário Doce 2024', '🎲 ◦ Sweet Birthday Event 2024', '🎲 ◦ Evento de Cumpleaños Dulce 2024', '🎲 ◦ Acara Ulang Tahun Manis 2024'), 
lng('🎲 ◦ Evento da Fábrica de Chocolate', '🎲 ◦ Chocolate Factory Event', '🎲 ◦ Evento de la Fábrica de Chocolate', '🎲 ◦ Acara Pabrik Cokelat'), 
lng('🎲 ◦ Aventura Lendária 7', '🎲 ◦ Legendary Adventure 7', '🎲 ◦ Aventura Legendaria 7', '🎲 ◦ Petualangan Legendaris 7'), 
lng('🎲 ◦ Halloween Assombrado', '🎲 ◦ Haunted Halloween', '🎲 ◦ Halloween Embrujado', '🎲 ◦ Halloween Berhantu'), 
lng('🎲 ◦ O Caso do Cão Sombrio', '🎲 ◦ The Case of the Dark Hound', '🎲 ◦ El Caso del Sabueso Oscuro', '🎲 ◦ Kasus Anjing Gelap'), 
lng('🎲 ◦ Aventura Lendária 8', '🎲 ◦ Legendary Adventure 8', '🎲 ◦ Aventura Legendaria 8', '🎲 ◦ Petualangan Legendaris 8'),
lng('🎲 ◦ Aventura Egípcia', '🎲 ◦ Egyptian Adventure Event', '🎲 ◦ Aventura Egipcia', '🎲 ◦ Petualangan Mesir'), 
lng('🎲 ◦ Evento Colinas Nebulosas', '🎲 ◦ Misty Hills Event', '🎲 ◦ Evento Colinas Nebulosas', '🎲 ◦ Acara Bukit Berkabut'),      
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if FT == nil then return end
    if FT == 1 then hack230() end
    if FT == 2 then hack231() end
    if FT == 3 then hack232() end
    if FT == 4 then hack233() end
    if FT == 5 then hack234() end
    if FT == 6 then hack235() end
    if FT == 7 then hack236() end
    if FT == 8 then hack237() end
    if FT == 9 then hack238() end
    if FT == 10 then hack239() end
    if FT == 11 then hack240() end
    if FT == 12 then hack241() end
    if FT == 13 then hack242() end
    if FT == 14 then hack243() end
    if FT == 15 then hack244() end
    if FT == 16 then hack245() end
    if FT == 17 then hack246() end
    if FT == 18 then hack247() end
    if FT == 19 then hack248() end
    if FT == 20 then hack249() end
    if FT == 21 then hack250() end
    if FT == 22 then hack251() end
    if FT == 23 then hack252() end
    if FT == 24 then hack253() end
    if FT == 25 then hack254() end
    if FT == 26 then hack255() end
    if FT == 27 then hack256() end
    if FT == 28 then hack257() end
    if FT == 29 then hack258() end
    if FT == 30 then hack259() end
    if FT == 31 then hack260() end
    if FT == 32 then hack261() end
    if FT == 33 then hack262() end
    if FT == 34 then hack263() end
    if FT == 35 then hack264() end
    if FT == 36 then hack265() end
    if FT == 37 then hack266() end
    if FT == 38 then hack267() end
    if FT == 39 then hack268() end
    if FT == 40 then hack269() end
    if FT == 41 then hack270() end    
    if FT == 42 then menuescolhas(24) end    
    if FT == 43 then menuescolhas(24) end

  elseif menu_tipo == 246 then
    FT = gg.choice({
lng('🎲 ◦ Vista Romântica', '🎲 ◦ Romantic Overlook', '🎲 ◦ Mirador Romántico'),
lng('🎲 ◦ Colapso Postal', '🎲 ◦ Postal Collapse', '🎲 ◦ Colapso Postal'), 
lng('🎲 ◦ Festival das Lanternas', '🎲 ◦ Lantern Festival Event', '🎲 ◦ Festival de Faroles'), 
lng('🎲 ◦ Febre do Amor', '🎲 ◦ Love Fever', '🎲 ◦ Fiebre del Amor'), 
lng('🎲 ◦ Febre das Gemas', '🎲 ◦ Gem Fever', '🎲 ◦ Fiebre de Gemas'), 
lng('🎲 ◦ Maratona de Março', '🎲 ◦ Marathon Event March', '🎲 ◦ Maratón de Marzo'), 
lng('🎲 ◦ Diversão de Páscoa', '🎲 ◦ Easter Fun', '🎲 ◦ Diversión de Pascua'), 
lng('🎲 ◦ Caçada ao Yeti', '🎲 ◦ Wild Yeti Chase', '🎲 ◦ Caza del Yeti'), 
lng('🎲 ◦ Makeover Jazzístico', '🎲 ◦ Jazzy Makeover', '🎲 ◦ Cambio de Imagen Jazz'),
lng('🎲 ◦ Odisseia Marciana', '🎲 ◦ Martian Odyssey', '🎲 ◦ Odisea Marciana'), 
lng('🎲 ◦ Maldição do Faraó', '🎲 ◦ Pharaoh\'s Curse', '🎲 ◦ Maldición del Faraón'), 
lng('🎲 ◦ Celebração Chinesa', '🎲 ◦ Chinese Celebration', '🎲 ◦ Celebración China'),
lng('🎲 ◦ Reino de Contos de Fadas', '🎲 ◦ Fairytale Kingdom', '🎲 ◦ Reino de Cuentos de Hadas'), 
lng('🎲 ◦ Mundo Viking', '🎲 ◦ Viking World', '🎲 ◦ Mundo Vikingo'), 
lng('🎲 ◦ Festa Botânica', '🎲 ◦ Botanical Bonanza', '🎲 ◦ Festín Botánico'),
lng('🎲 ◦ Histórias de Detetive', '🎲 ◦ Detective Stories', '🎲 ◦ Historias de Detectives'),
lng('🎲 ◦ Mistérios de Atlântida', '🎲 ◦ Mysteries of Atlantis', '🎲 ◦ Misterios de la Atlántida'), 
lng('🎲 ◦ Chamado da Selva', '🎲 ◦ Call of the Jungle', '🎲 ◦ Llamado de la Selva'), 
lng('🎲 ◦ Ilha Perdida', '🎲 ◦ Lost Island', '🎲 ◦ Isla Perdida'),
lng('🎲 ◦ Aventura Culinária', '🎲 ◦ Culinary Adventure', '🎲 ◦ Aventura Culinaria'), 
lng('🎲 ◦ Aniversário Doce', '🎲 ◦ Sweet Birthday', '🎲 ◦ Dulce Cumpleaños'), 
lng('🎲 ◦ Mansão Misteriosa', '🎲 ◦ Mystery Estate', '🎲 ◦ Mansión Misteriosa'), 
lng('🎲 ◦ Festa dos Vampiros', '🎲 ◦ Vampire Party Event', '🎲 ◦ Fiesta de Vampiros'),
lng('🎲 ◦ Aventura na Floresta', '🎲 ◦ Forest Adventure', '🎲 ◦ Aventura en el Bosque'), 
lng('🎲 ◦ Aventura Infinita', '🎲 ◦ Infinite Adventure', '🎲 ◦ Aventura Infinita'), 
lng('🎲 ◦ Expedição Klondike', '🎲 ◦ Klondike Expedition', '🎲 ◦ Expedición Klondike'), 
lng('🎲 ◦ Milagres de Natal', '🎲 ◦ Christmas Miracles', '🎲 ◦ Milagros de Navidad'), 
lng('🎲 ◦ Torneio Esportivo', '🎲 ◦ Sports Tournament', '🎲 ◦ Torneo Deportivo'), 
lng('🎲 ◦ Inverno Esportivo', '🎲 ◦ Sporty Winter', '🎲 ◦ Invierno Deportivo'),
lng('🎲 ◦ Vila de Inverno', '🎲 ◦ Winter Village Event', '🎲 ◦ Villa Invernal'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if FT == nil then return end
    if FT == 1 then hack_photo(1, 1) end
    if FT == 2 then hack_photo(2, 1) end
    if FT == 3 then hack_photo(3, 1) end
    if FT == 4 then hack_photo(4, 1) end
    if FT == 5 then hack_photo(5, 1) end
    if FT == 6 then hack_photo(6, 1) end
    if FT == 7 then hack_photo(7, 1) end
    if FT == 8 then hack_photo(8, 1) end
    if FT == 9 then hack_photo(9, 1) end
    if FT == 10 then hack_photo(10, 1) end
    if FT == 11 then hack_photo(11, 1) end
    if FT == 12 then hack_photo(12, 1) end
    if FT == 13 then hack_photo(13, 1) end
    if FT == 14 then hack_photo(14, 1) end
    if FT == 15 then hack_photo(15, 1) end
    if FT == 16 then hack_photo(16, 1) end
    if FT == 17 then hack_photo(17, 1) end
    if FT == 18 then hack_photo(18, 1) end
    if FT == 19 then hack_photo(19, 1) end
    if FT == 20 then hack_photo(20, 1) end
    if FT == 21 then hack_photo(21, 1) end
    if FT == 22 then hack_photo(22, 1) end
    if FT == 23 then hack_photo(23, 1) end
    if FT == 24 then hack_photo(24, 1) end
    if FT == 25 then hack_photo(25, 1) end
    if FT == 26 then hack_photo(26, 1) end
    if FT == 27 then hack_photo(27, 1) end
    if FT == 28 then hack_photo(28, 1) end
    if FT == 29 then hack_photo(29, 1) end
    if FT == 30 then hack_photo(30, 1) end
    if FT == 31 then menuescolhas(24) end

  elseif menu_tipo == 247 then
    FT = gg.choice({
lng('🎲 ◦ Porco Calendário', '🎲 ◦ Calendar Pig', '🎲 ◦ Calendario Cerdo', '🎲 ◦ Babi Kalender'),
lng('🎲 ◦ Ovelhas De Serviço', '🎲 ◦ Service Sheep', '🎲 ◦ Ovejas De Servicio', '🎲 ◦ Domba Pelayan'), 
lng('🎲 ◦ Alegre Eugênio', '🎲 ◦ Joyful Eugene', '🎲 ◦ Eugenio Alegre', '🎲 ◦ Eugene yang Ceria'), 
lng('🎲 ◦ Governante Ovelha', '🎲 ◦ Ruler Sheep', '🎲 ◦ Oveja Gobernante', '🎲 ◦ Domba Penguasa'), 
lng('🎲 ◦ Frango Sábio', '🎲 ◦ Wise Chicken', '🎲 ◦ Pollo Sabio', '🎲 ◦ Ayam Bijaksana'), 
lng('🎲 ◦ Eugene e Susie', '🎲 ◦ Eugene and Susie', '🎲 ◦ Eugenio y Susie', '🎲 ◦ Eugene dan Susie'), 
lng('🎲 ◦ Toupeira Mineira', '🎲 ◦ Miner Mole', '🎲 ◦ Topo Minero', '🎲 ◦ Tikus Tanah Penambang'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali') 
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if FT == nil then return end
    if FT == 1 then hack_photo(41, 2) end
    if FT == 2 then hack_photo(42, 2) end
    if FT == 3 then hack_photo(43, 2) end
    if FT == 4 then hack_photo(44, 2) end
    if FT == 5 then hack_photo(45, 2) end
    if FT == 6 then hack_photo(46, 2) end
    if FT == 7 then hack_photo(47, 2) end
    if FT == 8 then menuescolhas(24) end

  elseif menu_tipo == 255 then
    FTc = gg.choice({
lng('🎲 ◦ Ponte De Vidro', '🎲 ◦ Glass Bridge', '🎲 ◦ Puente de Cristal', '🎲 ◦ Jembatan Kaca'),
lng('🎲 ◦ Ponte De Pedra', '🎲 ◦ Stone Bridge', '🎲 ◦ Puente de Piedra', '🎲 ◦ Jembatan Batu'),
lng('🎲 ◦ Ponte De Madeira', '🎲 ◦ Wooden Bridge', '🎲 ◦ Puente de Madera', '🎲 ◦ Jembatan Kayu'),
lng('🎲 ◦ Ponte Veneziana', '🎲 ◦ Venetian Bridge', '🎲 ◦ Puente Veneziano', '🎲 ◦ Jembatan Venesia'),
lng('🎲 ◦ Cerca Dourada', '🎲 ◦ Golden Fence', '🎲 ◦ Cerca Dorada', '🎲 ◦ Pagar Emas'),
lng('🎲 ◦ Cerca De Natal', '🎲 ◦ Christmas Fence', '🎲 ◦ Cerca de Navidad', '🎲 ◦ Pagar Natal'),
lng('🎲 ◦ Cerca De Páscoa', '🎲 ◦ Easter Fence', '🎲 ◦ Cerca de Pascua', '🎲 ◦ Pagar Paskah'),
lng('🎲 ◦ Cerca De Flores', '🎲 ◦ Flower Fence', '🎲 ◦ Cerca de Flores', '🎲 ◦ Pagar Bunga'),
lng('🎲 ◦ Portão De Flores', '🎲 ◦ Flower Gate', '🎲 ◦ Puerta de Flores', '🎲 ◦ Gerbang Bunga'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if FTc == nil then return end
    if FTc == 1 then hackd(54) end
    if FTc == 2 then hackd(55) end
    if FTc == 3 then hackd(56) end
    if FTc == 4 then hackd(57) end
    if FTc == 5 then hackd(58) end
    if FTc == 6 then hackd(59) end
    if FTc == 7 then hackd(60) end
    if FTc == 8 then hackd(61) end
    if FTc == 9 then hackd(62) end
    if FTc == 10 then menuescolhas(21) end

  elseif menu_tipo == 26 then
    FGs = gg.choice({
lng('💎 ◦ Lingote Bronze', '💎 ◦ Bronze Ingot', '💎 ◦ Lingote de Bronce', '💎 ◦ Batangan Perunggu'),
lng('💎 ◦ Lingote Prata', '💎 ◦ Silver Ingot', '💎 ◦ Lingote de Plata', '💎 ◦ Batangan Perak'),
lng('💎 ◦ Lingote Ouro', '💎 ◦ Golden Ingot', '💎 ◦ Lingote de Oro', '💎 ◦ Batangan Emas'),
lng('💎 ◦ Lingote Platina', '💎 ◦ Platinum Ingot', '💎 ◦ Lingote de Platino', '💎 ◦ Batangan Platinum'),
lng('💎 ◦ Minério Bronze', '💎 ◦ Bronze Ore', '💎 ◦ Mineral de Bronce', '💎 ◦ Bijih Perunggu'),
lng('💎 ◦ Minério Prata', '💎 ◦ Silver Ore', '💎 ◦ Mineral de Plata', '💎 ◦ Bijih Perak'),
lng('💎 ◦ Minério Ouro', '💎 ◦ Golden Ore', '💎 ◦ Mineral de Oro', '💎 ◦ Bijih Emas'),
lng('💎 ◦ Minério Platina', '💎 ◦ Platinum Ore', '💎 ◦ Mineral de Platino', '💎 ◦ Bijih Platinum'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if FGs == nil then return end
    if FGs == 1 then hack("lg1") end
    if FGs == 2 then hack("lg2") end
    if FGs == 3 then hack("lg3") end
    if FGs == 4 then hack("lg4") end
    if FGs == 5 then hack("lg5") end
    if FGs == 6 then hack("lg6") end
    if FGs == 7 then hack("lg7") end
    if FGs == 8 then hack("lg8") end
    if FGs == 9 then menuescolhas(2) end

  elseif menu_tipo == 28 then
    FGM = gg.choice({
lng('🧪 • Laboratório', '🧪 • Lab Boosters', '🧪 • Laboratorio', '🧪 • Laboratorium'),
lng('🕹️ • Minigame', '🕹️ • Minigame', '🕹️ • Minijuego', '🕹️ • Minigame'),
lng('🎁 • Vantagens', '🎁 • Perks', '🎁 • Ventajas', '🎁 • Keuntungan'),
lng('🚜 ◦ Celeiro Infinito', '🚜 ◦ Spacious Barn', '🚜 ◦ Granero Infinito', '🚜 ◦ Gudang Tak Berujung'),
lng('🧱 ◦ Construções Rápida', '🧱 ◦ Speedy Construction', '🧱 ◦ Construcciones Rápidas', '🧱 ◦ Konstruksi Cepat'),
lng('🍂 ◦ Plantação Rápida', '🍂 ◦ Speedy Plantation', '🍂 ◦ Plantación Rápidaes', '🍂 ◦ Perkebunan Cepat'),
lng('🚀 ◦ Fichas Loja Regata', '🚀 ◦ Regatta Store Tokens', '🚀 ◦ Fichas Tienda Regata', '🚀 ◦ Token Toko Regatta'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if FGM == nil then return end
    if FGM == 1 then menuescolhas(29) end
    if FGM == 2 then menuescolhas(30) end
    if FGM == 3 then menuescolhas(31) end
    if FGM == 4 then hcl() end
    if FGM == 5 then hcr() end
    if FGM == 6 then hack("x") end
    if FGM == 7 then hack("p") end
    if FGM == 8 then menuescolhas(1) end

  elseif menu_tipo == 29 then
    FGG = gg.choice({
lng('🧪 ◦ Booster Tempo Envio', '🧪 ◦ Ship Time Booster', '🧪 ◦ Booster Tiempo Envío', '🧪 ◦ Booster Waktu Pengiriman'),
lng('🧪 ◦ Booster Tempo Trem', '🧪 ◦ Train Time Booster', '🧪 ◦ Booster Tiempo Tren', '🧪 ◦ Booster Waktu Kereta'),
lng('🧪 ◦ Booster Tempo Fundição', '🧪 ◦ Smelt Time Booster', '🧪 ◦ Booster Tiempo Fundición', '🧪 ◦ Booster Waktu Peleburan'),
lng('🧪 ◦ Booster Tempo Mercado', '🧪 ◦ Market Time Booster', '🧪 ◦ Booster Tiempo Mercado', '🧪 ◦ Booster Waktu Pasar'),
lng('🧪 ◦ Booster Tempo Fábrica', '🧪 ◦ Factory Time Booster', '🧪 ◦ Booster Tiempo Fábrica', '🧪 ◦ Booster Waktu Pabrik'),
lng('🧪 ◦ Booster Tempo Pedido', '🧪 ◦ Order Time Booster', '🧪 ◦ Booster Tiempo Pedido', '🧪 ◦ Booster Waktu Pesanan'),
lng('🧪 ◦ Booster Tempo Colheira', '🧪 ◦ Harvest Speed Booster', '🧪 ◦ Booster Velocidad Cosecha', '🧪 ◦ Booster Kecepatan Panen'),
lng('🧪 ◦ Booster Colheita x2', '🧪 ◦ Harvest x2 Booster', '🧪 ◦ Booster Cosecha x2', '🧪 ◦ Booster Panen x2'),
lng('🧪 ◦ Booster Produto Agrícola x2', '🧪 ◦ Farm Product x2 Booster', '🧪 ◦ Booster Producto Agrícola x2', '🧪 ◦ Booster Produk Pertanian x2'),
lng('🧪 ◦ Booster Pedidos Moedas', '🧪 ◦ Order Coin Booster', '🧪 ◦ Booster Pedidos Monedas', '🧪 ◦ Booster Koin Pesanan'),
lng('🧪 ◦ Booster Donate Cooperativa', '🧪 ◦ Donate Booster Co-op', '🧪 ◦ Booster Donar Cooperativa', '🧪 ◦ Booster Donasi Koperasi'),
lng('🧪 ◦ Booster Iluminação Mina', '🧪 ◦ Mina Lighting Booster', '🧪 ◦ Booster Iluminación Mina', '🧪 ◦ Booster Penerangan Tambang'),
lng('🧪 ◦ Fabricação 2x Fábrica', '🧪 ◦ Double Factory Booster', '🧪 ◦ Doble Fábrica Booster', '🧪 ◦ Booster Pabrik Ganda'),
lng('🧪 ◦ Booster Moedas Aeroporto', '🧪 ◦ Airport Coin Booster', '🧪 ◦ Booster Monedas Aeropuerto', '🧪 ◦ Booster Koin Bandara'),
lng('🧪 ◦ Tempo Ajuda Cooperativa', '🧪 ◦ COOP Help Time', '🧪 ◦ Tiempo Ayuda Cooperativa', '🧪 ◦ Waktu Bantuan Koperasi'),
lng('🧪 ◦ Booster X2 Ilha Lingote', '🧪 ◦ X2 Ingot Island', '🧪 ◦ Booster X2 Isla Lingote', '🧪 ◦ Booster Pulau Batangan x2'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali') 
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if FGG == nil then return end
    if FGG == 1 then hack("lb1") end
    if FGG == 2 then hack("lb2") end
    if FGG == 3 then hack("lb3") end
    if FGG == 4 then hack("lb4") end
    if FGG == 5 then hack("lb5") end
    if FGG == 6 then hack("lb6") end
    if FGG == 7 then hack("lb7") end
    if FGG == 8 then hack("lb8") end
    if FGG == 9 then hack("lb9") end
    if FGG == 10 then hack("lb10") end
    if FGG == 11 then hack("lb11") end
    if FGG == 12 then hack("lb17") end
    if FGG == 13 then hack("lb13") end
    if FGG == 14 then hack("lb14") end
    if FGG == 15 then hack("lb15") end
    if FGG == 16 then hack("lb16") end
    if FGG == 17 then menuescolhas(28) end

  elseif menu_tipo == 30 then
    FMM = gg.choice({
lng('🕹️ ◦ Vidas', '🕹️ ◦ Lives', '🕹️ ◦ Vidas', '🕹️ ◦ Nyawa'),
lng('🕹️ ◦ Bola Arco-Íris', '🕹️ ◦ Rainbow Ball', '🕹️ ◦ Pelota Arco-Íris', '🕹️ ◦ Bola Pelangi'),
lng('🕹️ ◦ Foguete', '🕹️ ◦ Rocket', '🕹️ ◦ Cohete', '🕹️ ◦ Roket'),
lng('🕹️ ◦ Dinamite', '🕹️ ◦ Dynamite', '🕹️ ◦ Dinamita', '🕹️ ◦ Dinamit'),
lng('🕹️ ◦ Hidrante', '🕹️ ◦ Hydrant', '🕹️ ◦ Hidrante', '🕹️ ◦ Hidran'),
lng('🕹️ ◦ Britadeira', '🕹️ ◦ Jackhammer', '🕹️ ◦ Martillo Neumático', '🕹️ ◦ Palu Pneumatik'),
lng('🕹️ ◦ Luva', '🕹️ ◦ Glove', '🕹️ ◦ Guante', '🕹️ ◦ Sarung Tangan'),
lng('🕹️ ◦ Pontos 2X', '🕹️ ◦ 2X Points', '🕹️ ◦ Puntos 2X', '🕹️ ◦ Poin 2X'),
lng('🕹️ ◦ Energia Expedição', '🕹️ ◦ Energy Expedition', '🕹️ ◦ Energía Expedición', '🕹️ ◦ Energi Ekspedisi'),
lng('🕹️ ◦ Dinamite Expedição', '🕹️ ◦ Dinamite Expedition', '🕹️ ◦ Dinamite Expedición', '🕹️ ◦ Dinamit Ekspedisi'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if FMM == nil then return end
    if FMM == 1 then hack("lm1")  end
    if FMM == 2 then hack("lm2") end
    if FMM == 3 then hack("lm02") end
    if FMM == 4 then hack("lm002") end
    if FMM == 5 then hack("lm3") end
    if FMM == 6 then hack("lm4") end
    if FMM == 7 then hack("lm5") end
    if FMM == 8 then hack("lm7") end
    if FMM == 9 then hack("lm6") end
    if FMM == 10 then hackevd() end
    if FMM == 11 then menuescolhas(28) end

  elseif menu_tipo == 31 then
    FMV = gg.choice({
lng('🎁 ◦ Vagão Espaçoso', '🎁 ◦ Spacious Railcar', '🎁 ◦ Vagón Espacioso', '🎁 ◦ Gerbong Luas'),
lng('🎁 ◦ Slot Reforço Laboratório', '🎁 ◦ Lab Booster Slot', '🎁 ◦ Ranura Reforzador Laboratorio', '🎁 ◦ Slot Penguat Lab'),
lng('🎁 ◦ Reforço Moedas Pedidos', '🎁 ◦ Order Coin Boost', '🎁 ◦ Refuerzo Monedas Pedidos', '🎁 ◦ Penguat Koin Pesanan'),
lng('🎁 ◦ Mercado Premium', '🎁 ◦ Premium Market', '🎁 ◦ Mercado Premium', '🎁 ◦ Pasar Premium'),
lng('🎁 ◦ Carga Avião Premium', '🎁 ◦ Airplane Load Premium', '🎁 ◦ Carga Avión Premium', '🎁 ◦ Muatan Pesawat Premium'),
lng('🎁 ◦ Acelerar Avião', '🎁 ◦ Speed Up Airplane', '🎁 ◦ Acelerar Avión', '🎁 ◦ Percepat Pesawat'),
lng('🎁 ◦ Casa da Sorte Trevo', '🎁 Clover Lucky House', '🎁 ◦ Casa Suerte Trébol', '🎁 ◦ Rumah Keberuntungan Semanggi'),
lng('🎁 ◦ Pular Cronômetro Tarefa', '🎁 ◦ Skip Task Timer', '🎁 ◦ Saltar Cronómetro Tarea', '🎁 ◦ Lewati Timer Tugas'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali') 
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if FMV == nil then return end
    if FMV == 1 then hack("lv1")  end
    if FMV == 2 then hack("lv2") end
    if FMV == 3 then hack("lv3") end
    if FMV == 4 then hack("lv4") end
    if FMV == 5 then hack("lv5") end
    if FMV == 6 then hack("lv6") end
    if FMV == 7 then hack("lv10") end
    if FMV == 8 then hack("lv11") end
    if FMV == 9 then menuescolhas(28) end

  elseif menu_tipo == 32 then
    FMc = gg.choice({
lng('🎲 ◦ Valentines Day', '🎲 ◦ Valentines Day', '🎲 ◦ Día de San Valentín', '🎲 ◦ Hari Valentine'),
lng('🎲 ◦ CNY', '🎲 ◦ CNY', '🎲 ◦ Año Nuevo Chino', '🎲 ◦ Tahun Baru Imlek'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if FMc == nil then return end
    if FMc == 1 then hack03() end
    if FMc == 2 then hack03b() end
    if FMc == 3 then menuescolhas(10) end

  elseif menu_tipo == 33 then
    FMc = gg.choice({
lng('🎲 ◦ Pedra', '🎲 ◦ Stone', '🎲 ◦ Piedra', '🎲 ◦ Batu'),
lng('🎲 ◦ Tradições', '🎲 ◦ Traditions', '🎲 ◦ Tradiciones', '🎲 ◦ Tradisi'),
lng('🎲 ◦ Cidade Dos Sonhos', '🎲 ◦ Dream City', '🎲 ◦ Ciudad de los Sueños', '🎲 ◦ Kota Impian'),
lng('🎲 ◦ Fazenda', '🎲 ◦ Farm', '🎲 ◦ Granja', '🎲 ◦ Pertanian'),
lng('🎲 ◦ Dia Da Cidade', '🎲 ◦ City Day', '🎲 ◦ Día de la Ciudad', '🎲 ◦ Hari Kota'),
lng('🎲 ◦ Halloween', '🎲 ◦ Halloween', '🎲 ◦ Halloween', '🎲 ◦ Halloween'),
lng('🎲 ◦ Natalina', '🎲 ◦ Christmas', '🎲 ◦ Navidad', '🎲 ◦ Natal'),
lng('🎲 ◦ Velho Oeste', '🎲 ◦ Wild West', '🎲 ◦ Viejo Oeste', '🎲 ◦ Barat Liar'),
lng('🎲 ◦ Neon Da Cidade', '🎲 ◦ City Neon', '🎲 ◦ Neón de la Ciudad', '🎲 ◦ Kota Neon'),
lng('🎲 ◦ Musical Da Cidade', '🎲 ◦ City Musical', '🎲 ◦ Musical de la Ciudad', '🎲 ◦ Musik Kota'),
lng('🎲 ◦ Notória', '🎲 ◦ Notorious', '🎲 ◦ Notoria', '🎲 ◦ Tersohor'),
lng('🎲 ◦ Artesão Da Cidade', '🎲 ◦ City Artisan', '🎲 ◦ Artesano de la Ciudad', '🎲 ◦ Pengrajin Kota'),
lng('🎲 ◦ Cidade De Cacto', '🎲 ◦ Cactus City', '🎲 ◦ Ciudad Cactus', '🎲 ◦ Kota Kaktus'),
lng('🎲 ◦ Cidade Mecânica', '🎲 ◦ Mechanical City', '🎲 ◦ Ciudad Mecánica', '🎲 ◦ Kota Mekanik'),
lng('🎲 ◦ Moinho', '🎲 ◦ Windmill', '🎲 ◦ Molino', '🎲 ◦ Kincir Angin'),
lng('🎲 ◦ Rancho Antigo', '🎲 ◦ Old Ranch', '🎲 ◦ Rancho Antiguo', '🎲 ◦ Peternakan Tua'),
lng('🎲 ◦ Cidade De Telona', '🎲 ◦ Movie City', '🎲 ◦ Ciudad de Película', '🎲 ◦ Kota Film'),
lng('🎲 ◦ Aviador', '🎲 ◦ Aviator', '🎲 ◦ Aviador', '🎲 ◦ Penerbang'),
lng('🎲 ◦ Aloha', '🎲 ◦ Aloha', '🎲 ◦ Aloha', '🎲 ◦ Aloha'),
lng('🎲 ◦ Cidade De Neve', '🎲 ◦ Snow City', '🎲 ◦ Ciudad Nevada', '🎲 ◦ Kota Salju'),
lng('🎲 ◦ Maquina De Chiclete', '🎲 ◦ Gumball Machine', '🎲 ◦ Máquina de Chicle', '🎲 ◦ Mesin Permen Karet'),
lng('🎲 ◦ Quiosque Vitaminas', '🎲 ◦ Vitamin Kiosk', '🎲 ◦ Quiosco de Vitaminas', '🎲 ◦ Kios Vitamin'),
lng('🎲 ◦ Casa Confortável', '🎲 ◦ Cozy House', '🎲 ◦ Casa Acogedora', '🎲 ◦ Rumah Nyaman'),
lng('🎲 ◦ Natalina', '🎲 ◦ Christmas', '🎲 ◦ Navidad', '🎲 ◦ Natal'),
lng('🎲 ◦ Ao Vivo', '🎲 ◦ Live Show', '🎲 ◦ En Vivo', '🎲 ◦ Langsung'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali'),
    }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if FMc == nil then return end
    if FMc == 1 then skinscp(56) end
    if FMc == 2 then skinscp(57) end
    if FMc == 3 then skinscp(58) end
    if FMc == 4 then skinscp(59) end
    if FMc == 5 then skinscp(60) end
    if FMc == 6 then skinscp(61) end
    if FMc == 7 then skinscp(62) end
    if FMc == 8 then skinscp(63) end
    if FMc == 9 then skinscp(64) end
    if FMc == 10 then skinscp(66) end
    if FMc == 11 then skinscp(67) end
    if FMc == 12 then skinscp(68) end
    if FMc == 13 then skinscp(69) end
    if FMc == 14 then skinscp(70) end
    if FMc == 15 then skinscp(71) end
    if FMc == 16 then skinscp(72) end
    if FMc == 17 then skinscp(73) end
    if FMc == 18 then skinscp(74) end
    if FMc == 19 then skinscp(75) end
    if FMc == 20 then skinscp(78) end
    if FMc == 21 then skinscp(79) end
    if FMc == 22 then skinscp(80) end
    if FMc == 23 then skinscp(81) end
    if FMc == 24 then skinscp(82) end
    if FMc == 25 then skinscp(83) end
    if FMc == 26 then menuescolhas(4) end

  elseif menu_tipo == 34 then
    FCC = gg.choice({
lng('📢 ◦ Resetar Key', '📢 ◦ Reset Key', '📢 ◦ Reiniciar Key', '📢 ◦ Reset Kunci'),
lng('📢 ◦ Resetar Idioma', '📢 ◦ Reset Language', '📢 ◦ Reiniciar Idioma', '📢 ◦ Reset Bahasa'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
    }, nil,lng([[╔══╗───────────╔═╗╔╗─╔╗───
╚╗╔╝╔═╗╔╦╦╗╔═╦╗║═╣║╚╗╠╣╔═╗
─║║─║╬║║║║║║║║║╠═║║║║║║║╬║
─╚╝─╚═╝╚══╝╚╩═╝╚═╝╚╩╝╚╝║╔╝
───────────────────────╚╝─]]))

    if FCC == nil then return end
    if FCC == 1 then apagarKey() end
    if FCC == 2 then apagarIdioma() end
    if FCC == 3 then MENU() end

  elseif menu_tipo == 35 then
    SST = gg.choice({
lng('🎲 ◦ Congratulations', '🎲 ◦ Congratulations', '🎲 ◦ Congratulations', '🎲 ◦ Selamat'),
lng('🎲 ◦ Archer Sheep', '🎲 ◦ Archer Sheep', '🎲 ◦ Archer Sheep', '🎲 ◦ Domba Pemanah'),
lng('🎲 ◦ Vampire Cow', '🎲 ◦ Vampire Cow', '🎲 ◦ Vampire Cow', '🎲 ◦ Sapi Vampir'),
lng('🎲 ◦ Cook Cow', '🎲 ◦ Vaca Cozinheira', '🎲 ◦ Vaca Cocinera', '🎲 ◦ Sapi Koki'),
lng('🎲 ◦ Detective Stories', '🎲 ◦ Histórias de Detetive', '🎲 ◦ Historias de Detective', '🎲 ◦ Kisah Detektif'),
lng('🎲 ◦ Chicken Witch', '🎲 ◦ Bruxa Galinha', '🎲 ◦ Bruja Gallina', '🎲 ◦ Penyihir Ayam'),
lng('🎲 ◦ Bee Mummy', '🎲 ◦ Múmia Abelha', '🎲 ◦ Momia Abeja', '🎲 ◦ Lebah Mumi'),
lng('🎲 ◦ Weresheep', '🎲 ◦ Ovelha Lobisomem', '🎲 ◦ Oveja Hombre Lobo', '🎲 ◦ Domba Werewolf'),
lng('🎲 ◦ Carrot Drake', '🎲 ◦ Dragão Cenoura', '🎲 ◦ Dragón Zanahoria', '🎲 ◦ Naga Wortel'),
lng('🎲 ◦ Farmer Pig', '🎲 ◦ Porquinho Fazendeiro', '🎲 ◦ Cerdito Granjero', '🎲 ◦ Babi Petani'),
lng('🎲 ◦ Thrifty Cow', '🎲 ◦ Vaca Econômica', '🎲 ◦ Vaca Ahorradora', '🎲 ◦ Sapi Hemat'),
lng('🎲 ◦ Happy Sheep', '🎲 ◦ Ovelha Feliz', '🎲 ◦ Oveja Feliz', '🎲 ◦ Domba Bahagia'),
lng('🎲 ◦ Ice-Skating Chicken', '🎲 ◦ Galinha Patinadora', '🎲 ◦ Pollo Patinador', '🎲 ◦ Ayam Seluncur Es'),
lng('🎲 ◦ Extraterrestrial Cow', '🎲 ◦ Vaca Extraterrestre', '🎲 ◦ Vaca Extraterrestre', '🎲 ◦ Sapi Alien'),
lng('🎲 ◦ Astronaut Piggy', '🎲 ◦ Porquinho Astronauta', '🎲 ◦ Cerdito Astronauta', '🎲 ◦ Babi Astronot'),
lng('🎲 ◦ Bee Mime', '🎲 ◦ Mímico Abelha', '🎲 ◦ Mimo Abeja', '🎲 ◦ Lebah Pantomim'),
lng('🎲 ◦ Chicken Chef', '🎲 ◦ Chef Galinha', '🎲 ◦ Chef Pollo', '🎲 ◦ Koki Ayam'),
lng('🎲 ◦ Duck Influencer', '🎲 ◦ Pato Influenciador', '🎲 ◦ Pato Influencer', '🎲 ◦ Bebek Influencer'),
lng('🎲 ◦ Musical Sheep', '🎲 ◦ Ovelha Musical', '🎲 ◦ Oveja Musical', '🎲 ◦ Domba Musik'),
lng('🎲 ◦ Genie Otter', '🎲 ◦ Lontra Gênio', '🎲 ◦ Nutria Genio', '🎲 ◦ Berang-berang Jin'),
lng('🎲 ◦ Artistic Chicken', '🎲 ◦ Galinha Artística', '🎲 ◦ Pollo Artístico', '🎲 ◦ Ayam Artistik'),
lng('🎲 ◦ Surprise Bee', '🎲 ◦ Abelha Surpresa', '🎲 ◦ Abeja Sorpresa', '🎲 ◦ Lebah Kejutan'),
lng('🎲 ◦ Rockin Cow', '🎲 ◦ Vaca Rockeira', '🎲 ◦ Vaca Rockera', '🎲 ◦ Sapi Rock'),
lng('🎲 ◦ Drummer Otter', '🎲 ◦ Lontra Baterista', '🎲 ◦ Nutria Baterista', '🎲 ◦ Berang-berang Drummer'),
lng('🎲 ◦ Carnival of Venice', '🎲 ◦ Carnaval de Veneza', '🎲 ◦ Carnaval de Venecia', '🎲 ◦ Karnaval Venesia'),
lng('🎲 ◦ Protocow', '🎲 ◦ Protocow', '🎲 ◦ Protocow', '🎲 ◦ Protokow'),
lng('🎲 ◦ Cavesheep', '🎲 ◦ Ovelha Caverna', '🎲 ◦ Oveja Cueva', '🎲 ◦ Domba Gua'),
lng('🎲 ◦ Seaside Vacation Chill', '🎲 ◦ Férias na Praia Relax', '🎲 ◦ Vacaciones en la Playa Relajadas', '🎲 ◦ Liburan Pantai Santai'),
lng('🎲 ◦ Seaside Vacation Tan', '🎲 ◦ Férias na Praia Bronze', '🎲 ◦ Vacaciones en la Playa Bronceada', '🎲 ◦ Liburan Pantai Gelap'),
lng('🎲 ◦ Bovine Film Buff', '🎲 ◦ Amante do Cinema Bovino', '🎲 ◦ Amante del Cine Bovina', '🎲 ◦ Pecinta Film Sapi'),
lng('🎲 ◦ Piggy Starlet', '🎲 ◦ Estrela de Cinema Porquinho', '🎲 ◦ Estrella de Cine Cerdito', '🎲 ◦ Bintang Film Babi'),
lng('🎲 ◦ Adventurous Chicken', '🎲 ◦ Galinha Aventureira', '🎲 ◦ Pollo Aventurero', '🎲 ◦ Ayam Petualang'),
lng('🎲 ◦ Brazilian Carnival', '🎲 ◦ Carnaval Brasileiro', '🎲 ◦ Carnaval Brasileño', '🎲 ◦ Karnaval Brasil'),
lng('🎲 ◦ Lantern Festival 2024', '🎲 ◦ Festival das Lanternas 2024', '🎲 ◦ Festival de las Linternas 2024', '🎲 ◦ Festival Lentera 2024'),
lng('🎲 ◦ Irish Journey', '🎲 ◦ Jornada Irlandesa', '🎲 ◦ Viaje Irlandés', '🎲 ◦ Perjalanan Irlandia'),
lng('🎲 ◦ Easter Adventure', '🎲 ◦ Aventura de Páscoa', '🎲 ◦ Aventura de Pascua', '🎲 ◦ Petualangan Paskah'),
lng('🎲 ◦ Rock Roll Festival', '🎲 ◦ Festival de Rock', '🎲 ◦ Festival de Rock', '🎲 ◦ Festival Rock'),
lng('🎲 ◦ Ancient World Chicken', '🎲 ◦ Galinha do Mundo Antigo', '🎲 ◦ Pollo del Mundo Antiguo', '🎲 ◦ Ayam Dunia Kuno'),
lng('🎲 ◦ Spy Games', '🎲 ◦ Jogos de Espionagem', '🎲 ◦ Juegos de Espionaje', '🎲 ◦ Permainan Mata-mata'),
lng('🎲 ◦ Brotherhood of the Knights', '🎲 ◦ Irmandade dos Cavaleiros', '🎲 ◦ Hermandad de los Caballeros', '🎲 ◦ Persaudaraan Ksatria'),
lng('🎲 ◦ Treasures of Atlantis', '🎲 ◦ Tesouros de Atlântida', '🎲 ◦ Tesoros de Atlántida', '🎲 ◦ Harta Karun Atlantis'),
lng('🎲 ◦ Wild Wild West', '🎲 ◦ Velho Oeste Selvagem', '🎲 ◦ Viejo Oeste Salvaje', '🎲 ◦ Barat Liar'),
lng('🎲 ◦ Beach Vacation', '🎲 ◦ Férias na Praia', '🎲 ◦ Vacaciones en la Playa', '🎲 ◦ Liburan Pantai'),
lng('🎲 ◦ Italian Holiday', '🎲 ◦ Férias Italianas', '🎲 ◦ Vacaciones Italianas', '🎲 ◦ Liburan Italia'),
lng('🎲 ◦ Sweet Birthday', '🎲 ◦ Aniversário Doce', '🎲 ◦ Cumpleaños Dulce', '🎲 ◦ Ulang Tahun Manis'),
lng('❌ ◦ Voltar', '❌ ◦ Back', '❌ ◦ Volver', '❌ ◦ Kembali')
     }, nil,lng('ESCOLHA UMA OPÇÃO', 'CHOOSE AN OPTION', 'ELIGE UNA OPCIÓN', 'PILIH SATU OPSI'))

    if SST == nil then return end
    if SST == 1 then hackss(0) end
    if SST == 2 then hackss(1) end
    if SST == 3 then hackss(2) end
    if SST == 4 then hackss(3) end
    if SST == 5 then hackss(4) end
    if SST == 6 then hackss(5) end
    if SST == 7 then hackss(6) end
    if SST == 8 then hackss(7) end
    if SST == 9 then hackss(8) end
    if SST == 10 then hackss(9) end
    if SST == 11 then hackss(10) end
    if SST == 12 then hackss(11) end
    if SST == 13 then hackss(12) end
    if SST == 14 then hackss(13) end
    if SST == 15 then hackss(14) end
    if SST == 16 then hackss(15) end
    if SST == 17 then hackss(16) end
    if SST == 18 then hackss(17) end
    if SST == 19 then hackss(18) end
    if SST == 20 then hackss(19) end
    if SST == 21 then hackss(20) end
    if SST == 22 then hackss(21) end
    if SST == 23 then hackss(22) end
    if SST == 24 then hackss(23) end
    if SST == 25 then hackss(24) end
    if SST == 26 then hackss(25) end
    if SST == 27 then hackss(26) end
    if SST == 28 then hackss(27) end
    if SST == 29 then hackss(28) end
    if SST == 30 then hackss(29) end
    if SST == 31 then hackss(30) end
    if SST == 32 then hackss(31) end
    if SST == 33 then hackss(32) end
    if SST == 34 then hackss(33) end
    if SST == 35 then hackss(34) end
    if SST == 36 then hackss(35) end
    if SST == 37 then hackss(36) end
    if SST == 38 then hackss(37) end
    if SST == 39 then hackss(38) end
    if SST == 40 then hackss(39) end
    if SST == 41 then hackss(40) end
    if SST == 42 then hackss(41) end
    if SST == 43 then hackss(42) end
    if SST == 44 then hackss(43) end
    if SST == 45 then hackss(44) end
    if SST == 46 then menuescolhas(4) end
  end
  MenuVisible = -1
end

---- MENU PRINCIPAL
function MENU()
  SalvarUltimoMenu(nil)
  local opcao = gg.choice({lng("🌟 • Alterar Recompensas", "🌟 • Change Rewards", "🌟 • Cambiar Recompensas", "🌟 • Ubah Hadiah"), lng("🏭 • Pular Tempo", "🏭 • Skip Timer", "🏭 • Saltar Tiempo", "🏭 • Lewati Waktu"), lng("🚂 • Variados", "🚂 • Miscellaneous", "🚂 • Misceláneos", "🚂 • Aneka Ragam"), lng('💵 • Dinheiro/Notas', '💵 • Money/Notes', '💵 • Dinero/Notas', '💵 • Uang/T-Cash'), lng("📢 • Configurações", "📢 • Settings", "📢 • Configuraciones", "📢 • Pengaturan"), lng("❌ ◦ Fechar", "❌ ◦ Exit", "❌ ◦ Cerrar", "❌ ◦ Tutup")}, nil, [[╔══╗───────────╔═╗╔╗─╔╗───
╚╗╔╝╔═╗╔╦╦╗╔═╦╗║═╣║╚╗╠╣╔═╗
─║║─║╬║║║║║║║║║╠═║║║║║║║╬║
─╚╝─╚═╝╚══╝╚╩═╝╚═╝╚╩╝╚╝║╔╝
───────────────────────╚╝─]])

  if opcao then
      if opcao == 1 then menuescolhas(1) end
      if opcao == 2 then menuescolhas(3) end
      if opcao == 3 then menuescolhas(6) end
      if opcao == 4 then menuescolhas(999) end
      if opcao == 5 then menuescolhas(34) end
      if opcao == 6 then os.exit() end
  end
end
 
  ---- CREDITOS DO MENU
  -- Tenta carregar a linguagem salva anteriormente
  lang = carregarIdioma()

  if lang == nil then
      -- Se não houver linguagem salva, exibe o menu de seleção

      langs = gg.choice({
        "🇧🇷 Português",
        "🇺🇸 English",
        "🇪🇸 Español",
        "🇮🇩 Indonesia"
      }, nil, [[╔══╗───────────╔═╗╔╗─╔╗───
╚╗╔╝╔═╗╔╦╦╗╔═╦╗║═╣║╚╗╠╣╔═╗
─║║─║╬║║║║║║║║║╠═║║║║║║║╬║
─╚╝─╚═╝╚══╝╚╩═╝╚═╝╚╩╝╚╝║╔╝
───────────────────────╚╝─]])

      if langs == 1 then
          lang = 1
      elseif langs == 2 then
          lang = 2
      elseif langs == 3 then
        lang = 3
     elseif langs == 4 then
        lang = 4
      else
          return -- Se o usuário cancelar, não faz nada
      end

      -- Salva a linguagem escolhida para uso futuro
      salvarIdioma(lang)
      premiuns = true
      MENU()
    else
    premiuns = true
    MENU()
  end

---- FUNÇÃO DE SAIR
function EXIT()
  gg.clearList()
  gg.setVisible(true)
  os.exit()
end

---- FUNÇÃO PRINCIPAL
while premiuns do
    if gg.isVisible(true) then
        MenuVisible = 1
        gg.setVisible(false)
    end
    if MenuVisible == 1 then
        MenuVisible = -1
        if UltimoMenu then
            menuescolhas(UltimoMenu) -- Reabre o último menu acessado
        else
            MENU()
        end
    end
end
