// Moroccan Phone Lookup Service - JavaScript Logic

document.addEventListener('DOMContentLoaded', function() {
    const phoneInput = document.getElementById('phoneInput');
    const lookupBtn = document.getElementById('lookupBtn');
    const errorMessage = document.getElementById('errorMessage');
    const resultsSection = document.getElementById('resultsSection');
    const displayNumber = document.getElementById('displayNumber');
    const operatorName = document.getElementById('operatorName');
    const operatorIcon = document.getElementById('operatorIcon');

    // Moroccan phone number validation
    function validateMoroccanNumber(phoneNumber) {
        // Remove all non-digit characters except +
        const cleanNumber = phoneNumber.replace(/[^\d+]/g, '');

        // Check if it starts with +212
        if (!cleanNumber.startsWith('+212')) {
            return { valid: false, error: 'Phone number must start with +212' };
        }

        // Check total length (including +212 should be 13 characters)
        if (cleanNumber.length !== 13) {
            return { valid: false, error: 'Moroccan phone numbers must be 13 characters long (+212XXXXXXXXX)' };
        }

        // Check if all characters after +212 are digits
        const digitsOnly = cleanNumber.substring(4);
        if (!/^\d{9}$/.test(digitsOnly)) {
            return { valid: false, error: 'Invalid phone number format' };
        }

        return { valid: true, number: cleanNumber };
    }

    // Detect Moroccan network operator based on prefix
    function detectOperator(phoneNumber) {
        const prefix = phoneNumber.substring(4, 6); // Get the two digits after +212

        switch (prefix) {
            case '05':
                return {
                    name: 'Orange Maroc',
                    color: '#FF7900',
                    icon: 'O'
                };
            case '06':
                // 06 can be Maroc Telecom or Inwi depending on the next digit
                const nextDigit = phoneNumber.substring(6, 7);
                if (['0', '1', '2', '3', '4'].includes(nextDigit)) {
                    return {
                        name: 'Maroc Telecom',
                        color: '#E30613',
                        icon: 'MT'
                    };
                } else {
                    return {
                        name: 'Inwi',
                        color: '#00AEEF',
                        icon: 'I'
                    };
                }
            case '07':
                // 07 can be Maroc Telecom or Inwi
                const nextDigit7 = phoneNumber.substring(6, 7);
                if (['0', '1', '2', '3', '4'].includes(nextDigit7)) {
                    return {
                        name: 'Maroc Telecom',
                        color: '#E30613',
                        icon: 'MT'
                    };
                } else {
                    return {
                        name: 'Inwi',
                        color: '#00AEEF',
                        icon: 'I'
                    };
                }
            default:
                return {
                    name: 'Unknown Operator',
                    color: '#666666',
                    icon: '?'
                };
        }
    }

    // Handle lookup button click
    lookupBtn.addEventListener('click', function() {
        const phoneNumber = phoneInput.value.trim();

        // Hide previous results and errors
        resultsSection.classList.add('hidden');
        errorMessage.classList.add('hidden');

        // Validate the phone number
        const validation = validateMoroccanNumber(phoneNumber);

        if (!validation.valid) {
            errorMessage.textContent = validation.error;
            errorMessage.classList.remove('hidden');
            phoneInput.focus();
            return;
        }

        // Detect operator
        const operator = detectOperator(validation.number);

        // Display results
        displayNumber.textContent = validation.number;
        operatorName.textContent = operator.name;
        operatorIcon.textContent = operator.icon;
        operatorIcon.style.backgroundColor = operator.color;

        // Show results section with animation
        resultsSection.classList.remove('hidden');
        resultsSection.style.animation = 'fadeIn 0.5s ease-in-out';
    });

    // Handle Enter key press in input
    phoneInput.addEventListener('keypress', function(e) {
        if (e.key === 'Enter') {
            lookupBtn.click();
        }
    });

    // Add input formatting and validation feedback
    phoneInput.addEventListener('input', function() {
        const value = this.value;
        errorMessage.classList.add('hidden');

        // Auto-format: if user types just numbers, add +212 prefix
        if (/^\d{9}$/.test(value.replace(/\s/g, ''))) {
            this.value = '+212' + value.replace(/\s/g, '');
        }
    });

    // Add CSS animation for results
    const style = document.createElement('style');
    style.textContent = `
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    `;
    document.head.appendChild(style);
});