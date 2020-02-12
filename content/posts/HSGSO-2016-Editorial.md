---
title: HSGSO 2016 Editorial
tags:
 - editorial
 - hsgso
 - vietnamese
date: 2017-05-01T17:00:00+07:00
---
Trong năm vừa rồi có kha khá nhiều bạn hỏi mình
cũng như các bạn khác trong BTC HSGSO 2016 (môn
Tin) về solution của contest. Vì hồi đó không có
thời gian (*thực ra là lười*) nên bọn mình chưa
có dịp chữa bài. Lần này mình quyết định làm cho
chót.

# Đề bài
Các bạn có thể tải đề bài gốc tại [đây](https://drive.google.com/file/d/0ByCMlnXUqIAIVmpSUWh6dHo1a2c/view).

# Lời giải
## Mục lục
1. [color](#color)
2. [domino](#domino)
3. [gift](#gift)
4. [letter-o](#letter-o)
5. [paren](#paren)
6. [polylines](#polylines)
7. [socket](#socket)
8. [zigzag](#zigzag)

## color
**Author**: Nguyễn Đinh Quang Minh
### Ăn điểm
Để có 10% đầu tiên cho bài này ta nhận thấy chỉ
có cách tô duy nhất là so le với \\(K = 2\\), như
vậy chỉ cần in \\(0\\) khi \\(K = 1\\) và \\(2\\) khi \\(K = 2
\\) là bạn đã cầm trong tay 1 điểm đầu tiên.

### Biểu diễn trạng thái
Ta sẽ tiếp cận bài toán, đầu tiên bằng phương
pháp quy hoạch động. Qhđ thường là hướng giải
đúng đối với những bài toán đếm. Để có thể
triển khai qhđ, ta cần biết cách biểu diễn
một trạng thái đang xây.

Để ý giới hạn của bảng là \\(3 \times N\\). Vì chỉ
có 3 ô nên ta hoàn toàn có thể biểu diễn trạng
thái của một cột bằng một \\(K-\\)mask - một số
có 3 chữ số trong đó các chữ số trong khoảng
\\(0\\) đến \\(K - 1\\) (theo cơ số \\(K\\)). 2 chữ số
liên tiếp phải khác nhau, nên số trạng thái
thỏa mãn một cột sẽ là \\(5 \times 4 \times 4 =
80\\) trạng thái với \\(K = 5\\).

Ta có thể có hàm quy hoạch động đơn giản
\\(f[i][mask]\\) là số cách điền \\(i\\) cột đầu tiên,
trong đó cột cuối cùng có trạng thái là \\(mask\\).
Từ \\(f[i][mask]\\) ta chuyển trạng thái sang
\\(f[i + 1][mask']\\), for hết \\(mask'\\) thỏa mãn.
Ta có thể thấy cách này có độ phức tạp
\\(O(80^2 N)\\), chưa đủ thỏa mãn cả subtask 2.
Kể cả khi ta chỉ lọc ra các \\(mask'\\) thỏa mãn
và for chúng, ta vẫn có độ phức tạp \\(O(3380 N)\\),
vẫn chưa thể thỏa mãn subtask 2.

### Cải tiến quy hoạch động
Thay vì chuyển trạng thái cả cột cùng lúc, ta
có thể thay bằng việc mỗi lần chỉ điền 1 ô, lần
lượt từ cột đầu sang cột cuối, mỗi cột điền
từ trên xuống dưới. Trạng thái ta lưu lại sẽ
là trạng thái của \\(K\\) ô cuối cùng ta điền.

Tại sao lại lưu như vậy? Thực chất, khi điền lần
lượt, ta chỉ cần quan tâm đến ô phía trên và
bên trái nó, tức ô cách ô hiện tại \\(1\\) và \\(K\\)
bước điền. Nhưng do ta cần tính cả các ô phía
sau nên ta phải lưu trạng thái của cả \\(K\\) ô
trước đó.

Gọi \\(f[i][j][mask]\\) là số cách điền các ô từ
đầu đến \\((i, j)\\), với \\(K\\) cuối cùng mình điền
được lưu trong \\(mask\\). Để chuyển sang ô tiếp
theo, ta cần for một trong \\(K\\) màu của ô
tiếp theo ô \\((i, j)\\). Như vậy đpt sẽ là
\\(O(100 * N * K * 3)\\) (\\(5^2 \times 4\\) trạng thái, do
khi lưu như này có thể tồn tại 2 ô liên tiếp
cùng màu), vừa khít qua subtask 2. Code hơi trâu
nhưng không sao, worth it, vì ta đã có 50% số
điểm.

Bạn có thể xem thêm 1 bài mình đã chữa có cách
qhđ tương tự ở [đây (bài Domino)](https://natsukagami.github.io/2017/04/21/2017-04-20-Training/).

### Nhân ma trận
Đối với những bạn đã biết về nhân ma trận, ta
có thể bỏ qua phần quy hoạch động cải tiến phía
trên và thay vào đó, cải tiến qhđ \\(O(80^2 N)\\)
thành nhân ma trận \\(O(80^3 \log N)\\). Việc
chuyển đổi không khó, thực chất ta chỉ cần
dựng bảng chuyển đổi \\(80 \times 80\\) xem 2 trạng
thái nào có thể chuyển được cho nhau, mũ \\(N-1\\)
lần lên rồi lấy ma trận \\(1 \times 80\\) toàn 1
(thể hiện hàng đầu) nhân cùng tích ban nãy,
ra được một ma trận \\(1 \times 80\\) mới, đáp số
chính là tổng các phần tử.

Việc nhân ma trận như nào chỉ là kĩ thuật cơ
bản nên mình sẽ không nói nhiều.

Kiến thức nhân ma trận, so với tối ưu quy hoạch
động như trên, là phổ thông hơn nhiều, vì thế
subtask 3 không cho nhiều điểm như subtask 2.

### 1 tỉ màu??
Đọc đến subtask 4 hẳn tất cả sẽ ngạc nhiên khi
\\(K\\) thay đổi đáng ngạc nhiên: từ \\(\le 5\\) và
là mấu chốt giải bài toán, thành \\(10^9\\) -
không còn đưa được vào độ phức tạp nữa. Để đào
sâu vào subtask này, ta cần có một nhận xét
về tương quan các màu giữa các cột.

#### Tương quan các màu
Trong một cột, chỉ có 2 loại tương quan sau:

 - \\(a,b,c\\) - tức 3 ô trong cột khác nhau
 - \\(a,b,a\\) - tức 2 ô đầu và cuối giống nhau

Hơn nữa, số cách chọn màu cho cột \\(i + 1\\) chỉ
phụ thuộc vào tương quan của hàng \\(i\\), theo bảng
sau:

- Từ \\(a, b, c\\):
	- Sang \\(a, b, c\\): có \\((K-1)+2(K-2)^2+
	(K-3)(K-1)+(K-3)(K-2)^2\\) cách.
	- Sang \\(a, b, a\\): có \\((K-1)+(K-3)(K-2)\\) cách.
- Từ \\(a, b, a\\):
	- Sang \\(a, b, c\\): có \\((K-1)+(K-3)(K-2)\\) cách.
	- Sang \\(a, b, a\\): có \\((K-1)+(K-2)^2\\) cách.

Việc chứng minh chỉ là công thức tổ hợp, mình sẽ
không chứng minh để chống dài dòng.

Như vậy ta không cần lưu cụ thể các màu, mà chỉ
cần tương quan giữa các màu, tức chỉ còn 2 trạng
thái để quản lí chứ không nhiều như trưóc. Việc qhđ để ăn sub 4
(độ phức tạp \\(O(2^2 N)\\)) hay nhân ma trận để ăn
sub 5 (độ phức tạp \\(O(2^3 \log N)\\)) có thể được
thực hiện đơn giản.

## domino
**Author**: thầy Hồ Đắc Phương
### Backtrack
Ở subtask 1, đơn giản ta chỉ cần backtrack
tất cả các cách đặt domino. Do bảng chỉ có
\\(2 \times 20\\) nên không có đến \\(2^{20}\\) cách đặt
là tối đa. Độ phức tạp sẽ là \\(O(2^N)\\).

### Bổ đề: lát gạch cơ bản
**Đếm số cách lát gạch vào bảng \\(2 \times N\\)**

Có lẽ đây là bài toán nổi tiếng trong giới
VNOI. Cách giải khá đơn giản: quy hoạch động
\\(f[i]\\) là số cách lát \\(i\\) cột đầu tiên. Ta
có 2 cách lát: 1 viên dọc (chuyển xuống
\\(f[i - 1]\\)) hoặc 2 viên ngang (chuyển xuống
\\(f[i - 2]\\)). Độ phức tạp là \\(O(N)\\), hoặc vì
đây là phương trình đệ quy tuyến tính nên
ta có thể nhân ma trận \\(O(2^3 \log N)\\).

Không khó để nhận ra \\(f[i]\\) cũng chính là
số fibonacci, ta cũng có 1 số cách tính
chính xác khác trong \\(O(\log N)\\).

### Cách điền duy nhất?
Để giải *tất cả subtask sau*, ta cần có chút quan
sát về các ô cấm:

- Nếu một cột bị cấm cả 2 ô, hiển nhiên ta
có bên trái và bên phải là 2 bài toán riêng
biệt, ta chỉ cần tính riêng 2 bên rồi nhân
vào nhau.
- Nếu một cột bị chặn 1 ô, hiển nhiên ô đó
thuộc một viên domino ngang. Ta sẽ phải lựa
chọn viên ngang đó nằm lệch về bên trái hay
bên phải.

Ngạc nhiên thay, cách chọn ô đó là duy nhất.
Để hiểu rõ tại sao, hãy xét 3 trường hợp sau:

##### Nhận 1 bên
![TH 1. Ô đỏ là ô cấm](/images/domino_one.png)

Hiển nhiên trong trường hợp này, số cách điền
là 0. Đơn là vì có lẻ ô.

##### Nhận 2 bên, điền được
![TH 2, cách điền duy nhất](/images/domino_two.png)

Xét cột thứ nhất, ta có cách điền domino duy
nhất. Con domino này chắn 1 ô của cột thứ hai,
làm cho bài toán đệ quy xuống. Tại mỗi bước
chỉ có một cách điền duy nhất nên với cả đoạn
cũng chỉ tồn tại 1 cách điền.

##### Nhận 2 bên, không điền được
![TH 3](/images/domino_three.png)

Giống như trường hợp trên, nhưng vì khi đặt
con domino cuối cùng, ta bị đặt trùng lên ô
cấm, nên ta không thể điền trường hợp này.

Phân biệt với TH 2 như nào? Ta điền được
khi và chỉ khi:

- Cả đoạn độ dài chẵn **và** 2 ô cấm cùng hàng,
*hoặc*
- Cả đoạn độ dài lẻ **và** 2 ô cấm khác hàng

### Cách tính
Xét một đoạn bị chắn 2 đầu là cột 2 ô cấm (hoặc
biên, ta có thể coi 2 biên là 2 cột 2 ô cấm).
Gọi \\(P_1, P_2, ..., P_K\\) là vị trí các cột có
1 ô cấm, từ trái sang phải.

Hiển nhiên nếu \\(K\\) lẻ thì có 0 cách điền vì có
lẻ ô.

![\\(P_1 = 3\\), \\(P_2 = 5\\), số cách điền là \\(f[2] \times 1 \times f[3]\\)](/images/domino_all.png)

Ta có:
- Xét đoạn \\(1..P_1\\): Hiển nhiên viên ở \\(P_1\\) sẽ
đặt sang phải vì nếu không ta sẽ có TH 1. Số
cách điền đoạn \\(1..P_1-1\\) là \\(f[P_1 - 1]\\).
- Xét đoạn \\(P_1..P_2\\): Vì viên ở \\(P_1\\) đặt trọn
trong đoạn nên \\(P_2\\) cũng vậy, nếu không sẽ
bị TH 1. Số cách điền là 0 hoặc 1 phụ thuộc
vào nó là TH 2 hay 3.
- Xét đoạn \\(P_2..P_3\\), vì viên ở \\(P_2\\) nằm
trọn bên trái nên trường hợp này như đoạn
\\(1..P_1\\), số cách chọn là \\(f[P_3 - P_2 - 1]\\).
- Vân vân, xét đến khi ta gặp \\(P_{2k}..N\\)
thì cũng như đoạn đầu, số cách là \\(f[N - 2k]\\).

Số cách điền cả đoạn sẽ là tích số cách điền
từng đoạn con.

Độ phức tạp là \\(O(N \log 10^9)\\), vì ta tính
\\(f[i]\\) trong \\(O(\log i)\\).

### Tại sao lại chia subtask như vậy?
Với \\(K = 4\\), bạn có thể mập mờ nhìn ra tính
chất trên khi chia tất cả trường hợp 4 ô cấm.
Bọn mình muốn hướng suy nghĩ phải theo mạch
tự nhiên, không bị gò bó.

## gift
**Author**: Nguyễn Đức Duy
### Thuật toán backtrack
Với \\(N \le 10\\), ta có thể thực hiện backtrack,
mỗi bước cho phần tử \\(i\\) cho Alice, Bob hoặc
giữ lại. Đến cuối, nếu có đáp án, ta in ra
và thoát chương trình.

Do mỗi bước ta có 3 lựa chọn nên độ phức tạp
là \\(O(3^N)\\).

### 22 phần tử
Với \\(N\\) lớn hơn, hẳn là lượng tập con
càng lớn so với giới hạn, vì thể xác suất
tồn tại đáp số càng lớn.
Ta sẽ chứng minh chỉ với 22 phần tử, luôn
luôn tồn tại đáp số.

Hiển nhiên, với 22 phần tử, ta có \\(2^{22} - 1\\)
tập con không rỗng.
Đồng thời, các tổng nằm trong khoảng \\(1..
22 \times 10^5\\).
Vì \\(2^22 - 1 > 22 \times 10^5\\) nên theo định
lí Dirichlet ta luôn có 2 tập có cùng tổng.

Gọi 2 tập này là \\(x\\) và \\(y\\). Chắc chắn 2 tập
này không phải tập con của nhau, vì mỗi phần
tử đều lớn hơn 0. Như vậy chắc chắn tồn tại
ít nhất 1 phần tử của mỗi tập mà không tồn
tại trong tập kia.

Ta loại đi các phần tử có trong cả 2 (vì
chúng cùng trừ cả 2 bên đi 1 lượng), và
còn lại 2 tập không rỗng. Đây chính là đáp số.

Như vậy, với \\(N \ge 22\\), ta chỉ cần bốc ra
22 phần tử rồi tính tất cả tổng tập con, lấy
2 tập bằng nhau và loại đi các phần tử trùng
là sẽ ra đáp số.

Độ phức tạp là \\(O(2^{22})\\).

### \\(N\\) "ất ơ"
Vậy với \\(10 < N < 22\\) thì sao? Rất tiếc bọn
mình không chuẩn bị được test mà giết được
thuật ở trên. Tuy nhiên, ta vẫn có thể
backtrack gặp nhau ở giữa, lần lượt backtrack
\\(3^{10}\\) trường hợp ở đầu và \\(3^{N - 10}\\)
trường hợp ở cuối, sau đó ghép 2 số có
hiệu trái dấu.
Như vậy độ phức tạp sẽ không quá \\(O(3^{N / 2})\\).

## letter-o
**Author**: mình

Lưu ý đây là bài output-only, vì vậy bạn có
5 tiếng để chạy chứ không phải 1 giây.
### Thuật toán \\(O(N^4)\\)
Thực ra thuật toán \\(O(N^4)\\) khá đơn giản, ta
chỉ cần for 2 góc của hình chữ nhật và kiểm
tra liệu 4 cạnh của chúng có chứa toàn cùng
kí tự không. Để kiểm tra ta có thể tính
trước mảng cộng dồn \\(O(N^2)\\).

Lấy thuật \\(O(N^4)\\) có thể chạy 1s đến input 5,
và ăn 50% số điểm.
Bài thật là dễ!

### Thuật toán \\(O(N^3)\\)
Ta nhận thấy, nếu ta for trước 2 cạnh song song
của hình chữ nhật, thì chỉ cần xét các vị trí
mà có toàn kí tự `x` nào đó trong cả đoạn nằm
giữa 2 cạnh. Ta sẽ chọn 2 điểm xa nhau nhất mà
2 điểm đó dọc 2 cạnh đều là các kí tự giống nhau.

```
11111
10021
10311
11111
10231
11111
10230
11111
```
Xét ví dụ trên, chọn 2 cột đầu cuối. Ta thấy
chỉ có các hàng 1, 4, 6 và 8 có thể làm 2
cạnh ngang của hình chữ nhật. Ngoài ra,
chỉ có 1, 4, 6 được nối với nhau. Ta chọn
hình lớn nhất (1 - 6).

Việc lựa chọn có thể được thực hiện chỉ trong
\\(O(N)\\) bằng một vòng for lưu max. Như vậy ta
có thuật \\(O(N^3)\\) đủ ăn input 6.

### Sức mạnh của input!
Đối với input 7 và 8, đáp số được đảm bảo là
lớn, nên bạn có thể sử dụng chiến thuật chỉ
bài output-only mới có: sử dụng mắt.

Với mỗi số ta có thể in ra vị trí của chúng
(và để trống những vị trí khác). Việc nhìn
bằng mắt cũng sẽ cho ta thấy một số hình lớn,
chỉ việc thử vào đáp số.

### Tìm kiếm pattern
Nếu nhìn kỹ, bạn có thể nhận ra input 9 có pattern
khá dị, khi chỉ có một số hình chữ nhật. Bạn có
thể nhìn tay và chỉ chạy các miền có hình chữ nhật
thỏa mãn.

### ... hoặc không
Để giải input 10, bạn cần phải nhận ra quy tắc
quan trọng nhất: bạn không bị giới hạn bởi thời
gian chạy của máy chấm. Vì thế hãy nhập input
10 vào, đặt cận đáp số và chờ 15-20 phút cho
máy chạy. Tính trên máy trường mình, chỉ mất
1h để chạy tất cả input với \\(O(N^3)\\) đặt cận
đáp số! Bạn có 5 tiếng cơ mà, chạy trâu rồi
làm bài khác... đó là chiến thuật của bài này.

## paren
**Author**: thầy Hồ Đắc Phương & Phạm Tùng
Dương.

### Đệ quy
Thực chất đây chỉ là một bài tính toán có
chút lằng nhằng. Phương thức tính toán như
sau, xét đoạn ngoặc \\(l..r\\) là 1 cặp ngoặc:

- Tính tất cả các cặp ngoặc con \\(l_1..r_1, ..., l_p..r_p\\)
- Độ cao của \\(l..r\\) là max độ cao của các cặp ngoặc con, cộng 1
- Độ dài của \\(l..r\\) là tổng độ dài của các cặp
ngoặc con, cộng \\(p-1\\) khoảng cách ở giữa,
cộng 2 hoặc 4 tùy loại ngoặc của \\(l..r\\)
- Phần tô màu của \\(l..r\\) là:
	- Nếu viền ngoài cùng của \\(l..r\\) là đen:
	độ dài \\(\times\\) độ cao \\(-\\) diện tích các hình con
	- Nếu không thì là 0
	- Sau đó cộng thêm phần tô màu các hình con

### Dựng cây
Để có thể dựng quan hệ cha - con và tính đệ quy
trong \\(O(N)\\), ta sẽ cần dựng cây bằng stack.
Cách dựng như sau:

- Duy trì 1 stack, lúc đầu stack rỗng
- Đi từ trái sang phải, giả sử kí tự ta có là
\\(S_x\\):
	- Nếu \\(S_x\\) là mở ngoặc: Nếu stack không rỗng,
	thì cặp ngoặc \\(x\\) có cha là đỉnh stack. Push
	\\(x\\) vào stack.
	- Nếu \\(x\\) là đóng ngoặc: xóa đỉnh stack.

Tổng độ phức tạp là \\(O(N)\\).

## polylines
**Author**: mình
### Quy hoạch động trâu cơ bản
Để đơn giản ta coi điểm xuất phát là \\(0\\),
đích là \\(M + 1\\).

Ta có công thức quy hoạch động: Gọi \\(f[i]\\) là
số đường đi kết thúc ở \\(i\\). Ta có
- \\(f[0] = 1\\)
- \\(f[i] = \sum\limits_{X_j \le X_i, Y_j \le Y_i, i \neq j}f[j]\\)
- Đáp số là \\(f[M + 1]\\) - 1.

Để có thứ tự qhđ ta chỉ cần sort các điểm theo cả 2 tọa độ tăng
dần.
Chỉ đơn giản vậy ta có thuật toán \\(O(N^2)\\).

### Tăng tốc!
Nhìn vào điều kiện của \\(j\\) ở hàm qhđ, ta nhận thấy hoàn toàn
có thể lấy nhanh tổng các \\(f[j]\\) bằng 1 cấu trúc
dữ liệu nào đó.

Nhận thấy, khi sort các phần tử theo \\(X\\) rồi lấy
các phần tử đứng trước, ta chỉ còn cần lọc
điều kiện \\(Y\\) là đủ. Việc này ta hoàn toàn có
thể sử dụng BIT để lấy nhanh, sort tọa độ BIT
theo \\(Y\\) rồi get prefix, update điểm.

Độ phức tạp là \\(O(N \log N)\\).

## socket
**Author**: Nguyễn Đức Duy
### Tìm đáp án
Không khó để nhận ra nếu chỉ có thể xếp được
\\(K\\) thiết bị, ta luôn lấy \\(K\\) thiết bị có
độ yêu cầu cao nhất. Vì vậy ta có thể sort
thiết bị theo yêu cầu giảm dần rồi chặt nhị
phân, kiểm tra xem có thể đặt \\(K\\) thiết bị
đầu tiên không.

### Xếp ổ điện như nào?
Ta có thể coi hệ thống ổ điện như một cây,
trong đó gốc nối với nguồn. Xét 2 ổ điện
\\(i\\) và \\(j\\), trong đó \\(i\\) gần gốc hơn \\(j\\).
Nếu \\(A_i\\) < \\(A_j\\), ta hoàn toàn có thể
đổi chỗ \\(i\\) và \\(j\\) và đáp án không thể
nhỏ hơn ban đầu. Vì thế, để xây cây từ gốc,
ta đặt các ổ điện theo thứ tự \\(A_i\\) giảm dần.

Với nhận xét trên, ta coi như \\(A_i\\) đã
được xếp giảm dần. Giờ ta BFS theo từng tầng,
dễ dàng nhận thấy khi xét tầng \\(x\\):
- Nếu tồn tại \\(B_i = x\\), lập tức phải đặt \\(i\\)
vào tầng đó. Nếu không đặt được thì kiểm
tra fail.
- Mỗi lần ở tầng \\(x\\) ta thêm ổ \\(j\\) vào,
thì bớt 1 chỗ ở tầng \\(x\\) và thêm \\(A_j\\) chỗ
ở tầng \\(x + 1\\). Vì \\(A_j\\) dương nên sau khi
thêm ta luôn có nhiều chỗ ở tầng \\(x + 1\\)
cho các \\(B_i > x\\) hơn ở tầng \\(x\\). *Vì vậy,*
- Nếu \\(B_i > x\\), ta nhường cho ổ điện nếu
còn, nếu không ta sẽ xét sau.

### Tóm tắt thuật toán
Ta chặt nhị phân \\(K\\), kiểm tra xem có thể
xếp \\(K\\) thiết bị \\(B[1..K]\\) vào không.

Để kiểm tra:
- Lúc đầu ở tầng 0 ta có 1 vị trí đặt (ổ điện)
- Nếu có nhiều \\(B[i] = x\\) hơn số vị trí đặt,
kiểm tra fail. Nếu không, đặt hết \\(B[i] = x\\).
- Nếu còn chỗ ở tầng \\(x\\) và còn ổ điện, đặt ổ
điện cho tầng \\(x + 1\\).
- Nếu còn chỗ, coi như chúng của tầng \\(x + 1\\).

Độ phức tạp sẽ là \\(O((N + M) \log M)\\), do các bước
kiểm tra chỉ là \\(O(N + M)\\).

## zigzag
### Trường hợp \\(K = 1\\)
Không khó để nhận thấy với 10 chữ số và điều
kiện phải thăm mỗi số ít nhất 1 lần và không
cần đúng thứ tự, ta sẽ cần sử dụng đến bitmask.
Từ ngôi nhà nguồn, ta cần bfs đến các đỉnh, tìm
đường đi ngắn nhất dựng ra đủ mask.

Trên đồ thị ta dựng ra các đỉnh \\((i, j, mask)\\),
tức đứng ở ô \\((i, j)\\) và tập các số đã đi qua là
\\(mask\\). Từ đỉnh \\((i, j)\\) ta đi đến các đỉnh lân
cận, thêm mask của đỉnh đó vào nếu cần, mất
1 bước. Đáp số là khoảng cách đến đỉnh gần nhất
có mask đầy đủ 10 bit.

Độ phức tạp là \\(O(NM2^{10})\\).

### \\(K\\) lớn hơn
Với \\(K\\) lớn đến \\(M \times N\\), ta không thể chỉ
đơn giản là chạy thuật toán trên \\(K\\) lần, vì
như vậy là không thỏa mãn giới hạn bài toán.

Thay vào đó, ta cần một cách để có thể chạy
tất cả các truy vấn một lúc.

### Lật ngược yêu cầu
Đề bài yêu cầu từ một ngôi nhà, ta đến một
ô bất kì, miễn là đủ mask trên đường đi. Ta
sẽ lật ngược yêu cầu lại, cho phép xuất phát
từ đỉnh bất kì, đi thoải mái, với điều kiện
kết thúc ở nhà và đủ mask trên đường đi.

Vậy điểm khác biệt là gì? Với bài toán không quan
trọng đích với mỗi nguồn, ta cần BFS với từng
nguồn riêng biệt. Tuy nhiên, với bài toán không
quan trọng nguồn, ta có thể thực hiện BFS song
song nhiều nguồn, để tính khoảng cách từ *nguồn
gần nhất* tới mỗi đỉnh, với độ phức tạp chỉ
bằng 1 lần BFS.

Nói cách khác, thay vì ta xuất phát từ \\((X_i,
Y_i, 0)\\), ta xuất phát từ tất cả các đỉnh
\\((i, j, 0)\\) và tìm đường từ đỉnh bất kì đến
\\((X_i, Y_i, 1023)\\). Để chạy song song, tưởng
tượng có một nguồn ảo nối đến tất cả nguồn
thật với trọng số 0. Như vậy, vì chỉ có 1
nguồn (ảo), nên độ phức tạp chỉ là \\(O(NM2^{10})\\).
