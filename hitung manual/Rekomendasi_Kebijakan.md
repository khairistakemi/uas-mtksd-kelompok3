**# Rekomendasi Kebijakan**
#### Dari hasil simulasi ketiga skenario, dapat dilihat masing-masing intervensi memiliki efek yang berbeda terhadap penyebaran penyakit.

**## A. Vaksinasi 50%**
#### Jika setengah populasi diberikan vaksin sebelum wabah dimulai, otomatis jumlah orang yang bisa tertular (S₀) langsung turun dari 99.990 menjadi 49.990.
#### Akibatnya, R₀ tetap 2,5000 namun Reff-nya menjadi 1,2498 karena virusnya "kehabisan target". Total infeksi kumulatif ∫I(t)dt = 43.846 orang 
#### selama simulasi 200 hari. Masalahnya, Reff masih di atas 1, artinya wabah tetap terjadi, namun penyebarannya menjadi lebih lambat.
#### Supaya wabah beneran terhenti, vaksinasi minimalnya harus 60% (ini disebut herd immunity threshold, rumusnya 1 − 1/R₀).

**## B. Karantina (nilai β dikurangi 50%)**
#### Jika kontak fisik antar individu dibatasi setengahnya, nilai β turun dari 0,25 jadi 0,125. Hal tersebut akan menurunkan nilai R₀ menjadi 1,2500.
#### Dari ketiga skenario, karantina paling efektif menurunkan total beban infeksi dengan ∫I(t)dt = 50.222 orang selama simulasi kurang dari 200 hari.
### dan puncak epidemi baru tercapai di hari ke-200 (ujung simulasi), artinya penyebaran sangat melambat.
### Kelemahannya susah diterapkan jangka panjang karena akan mengganggu perputaran ekonomi dan aktivitas sehari-hari.

**## C. Pengobatan (nilai γ dinaikkan 50%)**
#### Jika orang dapat disembuhkan lebih cepat, γ naik dari 0,10 jadi 0,15 dan R₀ menurun jadi 1,6667.
#### Ini yang paling lemah di antara tiga skenario karena virusnya tetap menyebar dengan sama cepatnya,
#### bedanya hanya orang akan menjadi lebih cepat sembuh. Total infeksi kumulatifnya ∫I(t)dt = 450.403 orang selama simulasi 200 hari.
#### masih jauh lebih tinggi dibanding karantina maupun vaksinasi, dengan puncak epidemi di hari ke-85.

**## Dari ketiga skenario, karantina dan vaksinasi paling efektif jika tujuannya untuk menekan total jumlah orang yang sakit,**
**## dengan selisih yang tidak terlalu jauh (43.846 dengan 50.222 hari-orang). Tapi jika mau wabahnya dapat terkendali (Reff < 1),**
**## satu intervensi aja tidak akan cukup karena ketiga skenario masih menghasilkan Reff > 1. Kombinasi vaksinasi + karantina adalah**
**## pilihan terbaik karena keduanya menekan dari kedua sisi sekaligus. Hal ini dikarenakan satu untuk mengurangi S₀,**
**## dan satu lagi untuk mengurangi β sehingga Reff bisa didorong di bawah 1.**
