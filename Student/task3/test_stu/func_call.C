// #include <stdio.h>

float f(float x){
    return x+1;
}

float ab(float x){//绝对值函数 
	if(x<0)
		return -1*x;
	return x;
}

int times_power2(int x,int p){
	while(p){
		x=x*2;
		p=p-1;
	}
	return x;
}

float Romberg(float a,float b,float ep,int n){
	//输入的a，b为积分上下界，ep为误差，M为最大迭代次数，n为开始的梯形积分分段数，f是被积函数 
	int i,k,j,M;float h,sum;float Rk[1000],Rk1[1000],temp[1000];
    M=10;
	h=(b-a)/n;sum=0;
	i = 1;
	while(i<n){//计算初值 
		sum=sum+f(a+i*h);
		i = i + 1;
	}
	Rk[0]=h*(f(a)/2+f(b)/2+sum);
	//printf("Rk[0]=%lf\n",Rk[0]);
    k=1;
	while(k<M&&ab(Rk[k-1]-Rk1[k-2])>=ep){
		//temp=Rk1;Rk1=Rk;Rk=temp;//更新向量 
        k=0;
        while(k<M){
            temp[k]=Rk1[k];
            k=k+1;
        }
        k=0;
        while(k<M){
            Rk1[k]=Rk[k];
            k=k+1;
        }
        k=0;
        while(k<M){
            Rk[k]=temp[k];
            k=k+1;
        }
		h=h/2;sum=0;
        i=1;
		while(i<=times_power2(1,k-1)*n){//插入点值 
			sum=sum+f(a+(2*i-1)*h);
            i=i+1;
		}
		//printf("i=%d,sum=%lf",i,sum);
		Rk[0]=sum*h+Rk1[0]/2;sum=4;
		j = 1;
		while(j<=k){//计算向量下一行 
			Rk[j]=Rk[j-1]+(Rk[j-1]-Rk1[j-1])/(sum-1);
			sum=sum*4;
			j = j + 1;
		}
        k=k+1;
	}
	//printf("k=%d,M=%d,k/M=%lf\n",k,M,k*1.0/M);//测试k/M用代码 
	sum=Rk[k-1];//返回值 
	return sum;
}

int main(){
	// float a = Romberg(0,10,0.0001,4);
	// printf("%f", a);
	int a = Romberg(0,10,0.01,4);
	return a % 256;
}