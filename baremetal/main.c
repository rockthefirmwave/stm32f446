#include "../cmsis/stm32f446xx.h"

#include "../cmsis/stm32f446xx.h"

void uart2_init(void) {
    // Включаем тактирование GPIOA и USART2
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;
    RCC->APB1ENR |= RCC_APB1ENR_USART2EN;

    // Устанавливаем PA2 (TX) в режим альтернативной функции AF7 (USART2)
    GPIOA->MODER &= ~(3 << (2 * 2));     // сброс MODER2
    GPIOA->MODER |=  (2 << (2 * 2));     // альтернативная функция

    GPIOA->AFR[0] &= ~(0xF << (4 * 2));  // сброс AFRL2
    GPIOA->AFR[0] |=  (7 << (4 * 2));    // AF7 = USART2

    // Настройка USART2: 115200 8N1, TX enable
    USART2->BRR = 0x8B; // при 16 МГц: 0x8B = 138 (≈115200)
    USART2->CR1 = USART_CR1_TE | USART_CR1_UE; // TX включен, USART включен
}

void uart2_send(char c) {
    while (!(USART2->SR & USART_SR_TXE)); // ждем, пока передатчик освободится
    USART2->DR = c;
}

void uart2_print(const char* s) {
    while (*s) {
        uart2_send(*s++);
    }
}


int main2(void)
{
    RCC->AHB1ENR |= RCC_AHB1ENR_GPIOAEN;

    GPIOA->MODER &= ~(3 << (5 * 2));
    GPIOA->MODER |= (1 << (5 * 2));

    while (1)
    {
        GPIOA->ODR ^= (1 << 5);
        for (volatile int i = 0; i < 1500000; i++)
            ;
    }
}
