# include<iostream>
# include<cstring>
using namespace std;

class student {
private:
	int rno; char name[50]; double fee;
public:
	student() {
		rno = 0;
		strcpy_s(name, "");
		fee = 0.0;
	}
		
	student(int no, char n[], double f) {
		rno = no; strcpy_s(name, n); fee = f;
	}
	
	void display() {
		cout << " roll no: " << rno << "\n name " << name << "\n fee " << fee << endl;
	}

};
int main() {
	student obj1(1524, "ramesh", 5561.21);
	obj1.display();
	return 0;
}
