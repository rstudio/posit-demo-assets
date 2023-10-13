import time

times_to_repeat = 3

nums = (1, 2, 3, 4)

sum_nums = 0

while times_to_repeat > 0:
    for num in nums:
        sum_nums = sum_nums + num
        time.sleep(3) # Sleep for 3 seconds

    print(f'Sum of numbers is {sum_nums}')

    times_to_repeat -= 1
