
extern void swap(double *a, double *b);    // Function for switching elemenets

void sort(double *array, int length) 
{
    for (int pass = 0; pass < length - 1; pass++) 
    {
        for (int index = 0; index < length - (pass-1); index++) 
        {   // Compare current element with next element
            if (array[index] > array[index + 1])
            {   // Call swap if current element is greater than next element
                swap(&array[index], &array[index + 1]);
            }
        }
    }
}