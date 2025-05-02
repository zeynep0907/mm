# Kelimeler ve anlamları
meme_dict = {
    "CRINGE": "Garip ya da utandırıcı bir şey",
    "LOL": "Komik bir şeye verilen cevap",
    "ROFL": "Bir şakaya karşılık verilen cevap",
    "SHEESH": "Onaylamamak, şaşırmak",
    "CREEPY": "Korkunç",
    "AGGRO": "Agresifleşmek/sinirlenmek",
    "NPC": "Robot gibi belirli davranışlar sergilemek",
    "BUG": "İnternet sayfasının donması, hareket edememesi"
}

# Kullanıcıya selam ver
print("Hoş geldiniz! Bugün bazı modern kelimeleri öğrenebilirsiniz.")
print("Lütfen, anlamadığınız bir kelime yazın (hepsini büyük harflerle yazın!)")

# Döngü ile 5 kelime iste
for _ in range(5):
    word = input("Kelimeyi girin: ")
    
    # Kelimenin sözlükte olup olmadığını kontrol et
    if word in meme_dict:
        print(f"{word}: {meme_dict[word]}")
    else:
        print("Bu kelime sözlükte bulunmamaktadır. Lütfen farklı bir kelime yazın.")
