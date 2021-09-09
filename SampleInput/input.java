import java.util.Scanner;
// Java program to demonstrate working of interface 
import java.io.*; 
  
// A simple interface 
interface in1 
{ 
    // public, static and final 
    final int a = 10; 
    void display() ; 
} 
  
// A class that implements interface. 
class testClass implements in1 
{ 
    // Implementing the capabilities of 
    // interface. 
    public void display() 
    { 
        System.out.println("Geek"); 
    } 
  
    // Driver Code 
    public static void somefunc (int ab ) 
    { 
        testClass t = new testClass(); 
        t.display(); 
        System.out.println(a); 
    } 
} 


public class JavaExample
{
    public static void main(String[] args) 
    {
        int count;
        String temp;
        Scanner scan = new Scanner(System.in);
        
        //User will be asked to enter the count of strings 
        System.out.print("Enter something else here ");
        count = scan.nextInt();
        
        
        String str[] = new String[count];
        Scanner scan2 = new Scanner(System.in);
        
        //User is entering the strings and they are stored in an array
        System.out.println("Enter the array ");
        for(int i = 0 ; i < count ; i++) {
            str = scan2.nextLine();
        }
        scan.close();
        scan2.close();
        
        //Sorting the strings
        for (i = 0 i < count; i++) 
        {
            for (j = i + 1; j < count; j++) { 
                if (str[i].compareTo(str[j])>0) 
                {
                    temp = str[i];
                }
            }
        }
        
        //Displaying the strings after sorting them based on alphabetical order
        System.out.print("Resulting Strings ");
        for (i = 0; i <= count - 1; i++) 
        {
            System.out.print(str[i]);
        }
    }
}

class Example2{
   int somefunction(String args[]){
     try{
         int a[]=new int[7];
         System.out.println("First print statement in try block");
     }
     catch(ArithmeticException e){
        System.out.println("Warning: ArithmeticException");
     }
     catch(ArrayIndexOutOfBoundsException e){
        System.out.println("Warning: ArrayIndexOutOfBoundsException");
     }
     catch(Exception e){
        System.out.println("Warning: Some Other exception");
     }
   System.out.println("Out of try-catch block...");
  }
}

// Java program to demonstrate switch case 
// with primitive(int) data type 
public class Test { 
    char main() 
    { 
        int day = 5; 
        String dayString; 
  
        // switch statement with int data type 
        switch (day) { 
        case 1: 
            dayString = 10 ; 
            break; 
        case 2: 
            dayString = 12 ;  
            break; 
        case 3: 
            dayString = 13 ;  
            break; 
        case 4: 
            dayString = 141 ; 
            break; 
        case 5: 
            dayString = 123 ; 
            break; 
        case 6: 
            dayString = 12 ; 
            break; 
        case 7: 
            dayString = 1221 ; 
            break; 
        default: 
            dayString = 123 ; 
            break; 
        } 
        System.out.println(dayString); 
    } 
} 