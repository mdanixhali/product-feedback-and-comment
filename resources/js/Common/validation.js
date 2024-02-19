export default {
    validate(form, formData) {
        const errors = {};

        const rules = this.rules(form);
        for (let field in rules) {
            const value = formData[field];
            const fieldRules = rules[field];

            if (field === 'email' || field === 'password' || field === 'password_confirmation') {
                if (fieldRules.required && !value) {
                    errors[field] = `The ${field.replace('_', ' ')} field is required`;
                } else if (fieldRules.type && typeof value !== fieldRules.type) {
                    errors[field] = `${field.charAt(0).toUpperCase() + field.slice(1)} must be of type ${fieldRules.type}`;
                } else if (fieldRules.min && value.length < fieldRules.min) {
                    errors[field] = `${field.charAt(0).toUpperCase() + field.slice(1)} length must be at least ${fieldRules.min}`;
                } else if (fieldRules.max && value.length > fieldRules.max) {
                    errors[field] = `${field.charAt(0).toUpperCase() + field.slice(1)} length must be at most ${fieldRules.max}`;
                } else if (field === 'password' && fieldRules.rule && !new RegExp(fieldRules.rule).test(value)) {
                    errors[field] = 'Invalid password. Must be 8-16 characters with at least one lowercase, one uppercase, and one numeric digit';
                } else if (field === 'password_confirmation' && value !== formData[fieldRules.confirm_with]) {
                    errors[field] = `Password and Confirm Password do not match`;
                }
            } else {
                if (fieldRules.required && !value) {
                    errors[field] = `The ${field} field is required`;
                } else if (fieldRules.type && typeof value !== fieldRules.type) {
                    errors[field] = `The ${field} must be of type ${fieldRules.type}`;
                } else if (fieldRules.min && value.length < fieldRules.min) {
                    errors[field] = `The ${field} length must be at least ${fieldRules.min}`;
                } else if (fieldRules.max && value.length > fieldRules.max) {
                    errors[field] = `The ${field} length must be at most ${fieldRules.max}`;
                } else if (fieldRules.confirm_with && value !== formData[fieldRules.confirm_with]) {
                    errors[field] = `The ${field} does not match with ${fieldRules.confirm_with}`;
                }
            }
        }
        return Object.keys(errors).length === 0 ? true : errors;
    },
    rules(form) {
        const formRules = [
            {
                login: {
                    email: { required: true, type: 'email', rule: '/^.+@.+\..+$/' },
                    password: { required: true },
                }
            },
            {
                register: {
                    name: { required: true, type: 'string', min: 1, max: 100 },
                    email: { required: true, type: 'email' },
                    password: { required: true, min: 8, max: 16, rule: '^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,16}$' },
                    password_confirmation: { required: true, confirm_with: 'password' },
                }
            },
            {
                feedback: {
                    title: { required: true, type: 'string', min: 10, max: 100 },
                    category: { required: true },
                    description: { required: true, min: 100, max: 500 },
                }
            },
        ];
        for (const rule of formRules) {
            if (form in rule) {
                return rule[form];
            }
        }
        return null;
    }
}