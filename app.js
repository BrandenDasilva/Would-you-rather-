// Question data - same 50+ questions from the iOS app
const QUESTIONS = [
    { optionA: "Have the ability to fly", optionB: "Have the ability to become invisible" },
    { optionA: "Live in a world without music", optionB: "Live in a world without movies" },
    { optionA: "Always have to sing instead of speak", optionB: "Always have to dance everywhere you go" },
    { optionA: "Be able to talk to animals", optionB: "Be able to speak all human languages" },
    { optionA: "Have a pause button for your life", optionB: "Have a rewind button for your life" },
    { optionA: "Live without the internet", optionB: "Live without air conditioning and heating" },
    { optionA: "Have the ability to time travel", optionB: "Have the ability to teleport" },
    { optionA: "Always be 10 minutes late", optionB: "Always be 20 minutes early" },
    { optionA: "Fight one horse-sized duck", optionB: "Fight 100 duck-sized horses" },
    { optionA: "Have unlimited battery life on all your devices", optionB: "Have free WiFi wherever you go" },
    { optionA: "Be able to control fire", optionB: "Be able to control water" },
    { optionA: "Never be able to use a touchscreen", optionB: "Never be able to use a keyboard" },
    { optionA: "Have dinner with your favorite historical figure", optionB: "Have dinner with your favorite fictional character" },
    { optionA: "Live in a treehouse", optionB: "Live in a cave" },
    { optionA: "Have a personal chef", optionB: "Have a personal chauffeur" },
    { optionA: "Always know what time it is", optionB: "Always know where north is" },
    { optionA: "Be the funniest person in the room", optionB: "Be the smartest person in the room" },
    { optionA: "Have a third arm", optionB: "Have a third eye" },
    { optionA: "Be able to read minds", optionB: "Be able to see the future" },
    { optionA: "Live in space", optionB: "Live underwater" },
    { optionA: "Have a personal robot", optionB: "Have a pet dragon" },
    { optionA: "Always have to whisper", optionB: "Always have to shout" },
    { optionA: "Never have to sleep", optionB: "Never have to eat" },
    { optionA: "Be stuck on a deserted island alone", optionB: "Be stuck on a deserted island with someone you can't stand" },
    { optionA: "Have the ability to change your hair color at will", optionB: "Have the ability to change your eye color at will" },
    { optionA: "Live in a world of permanent winter", optionB: "Live in a world of permanent summer" },
    { optionA: "Have a rewind button for conversations", optionB: "Have a fast-forward button for awkward situations" },
    { optionA: "Be able to run at super speed", optionB: "Be able to jump super high" },
    { optionA: "Have unlimited sushi for life", optionB: "Have unlimited tacos for life" },
    { optionA: "Always have wet socks", optionB: "Always have a small rock in your shoe" },
    { optionA: "Live in a world where everyone tells the truth", optionB: "Live in a world where everyone is kind" },
    { optionA: "Have a photographic memory", optionB: "Have the ability to forget anything you want" },
    { optionA: "Be able to breathe underwater", optionB: "Be able to survive in space without a suit" },
    { optionA: "Have a magic carpet", optionB: "Have a time machine" },
    { optionA: "Be the best player on a losing team", optionB: "Be the worst player on a winning team" },
    { optionA: "Have every song you've ever heard stuck in your head", optionB: "Have the same dream every night" },
    { optionA: "Be a famous inventor", optionB: "Be a famous explorer" },
    { optionA: "Have legs as long as your fingers", optionB: "Have fingers as long as your legs" },
    { optionA: "Always feel slightly cold", optionB: "Always feel slightly warm" },
    { optionA: "Have a completely automated smart home", optionB: "Have a vacation home on a tropical island" },
    { optionA: "Be able to control the weather", optionB: "Be able to control technology with your mind" },
    { optionA: "Have perfect pitch", optionB: "Have perfect balance" },
    { optionA: "Live without chocolate", optionB: "Live without cheese" },
    { optionA: "Be always slightly overdressed", optionB: "Be always slightly underdressed" },
    { optionA: "Have a lifetime supply of books", optionB: "Have a lifetime supply of video games" },
    { optionA: "Be able to shrink to the size of an ant", optionB: "Be able to grow to the size of a building" },
    { optionA: "Have to wear clown shoes every day", optionB: "Have to wear a clown nose every day" },
    { optionA: "Have the ability to never feel pain", optionB: "Have the ability to heal instantly" },
    { optionA: "Be a character in your favorite book", optionB: "Be a character in your favorite TV show" },
    { optionA: "Have taste buds on your fingers", optionB: "Have eyes in the back of your head" }
];

// App state
class QuestionManager {
    constructor() {
        this.questions = [];
        this.currentQuestion = null;
        this.selectedOption = null;
        this.loadData();
        
        if (this.questions.length === 0) {
            this.initializeQuestions();
        }
        
        this.selectNextQuestion();
    }

    initializeQuestions() {
        this.questions = QUESTIONS.map((q, index) => ({
            id: index,
            optionA: q.optionA,
            optionB: q.optionB,
            responseA: 0,
            responseB: 0,
            hasBeenAsked: false
        }));
        this.saveData();
    }

    selectNextQuestion() {
        const unaskedQuestions = this.questions.filter(q => !q.hasBeenAsked);
        
        if (unaskedQuestions.length === 0) {
            // Reset all questions
            this.questions.forEach(q => q.hasBeenAsked = false);
            this.saveData();
        }
        
        const availableQuestions = this.questions.filter(q => !q.hasBeenAsked);
        if (availableQuestions.length > 0) {
            const randomIndex = Math.floor(Math.random() * availableQuestions.length);
            this.currentQuestion = availableQuestions[randomIndex];
        } else if (this.questions.length > 0) {
            this.currentQuestion = this.questions[0];
        }
    }

    recordResponse(option) {
        if (!this.currentQuestion) return;
        
        const questionIndex = this.questions.findIndex(q => q.id === this.currentQuestion.id);
        if (questionIndex === -1) return;

        if (option === 'A') {
            this.questions[questionIndex].responseA++;
        } else {
            this.questions[questionIndex].responseB++;
        }

        // Note: We don't mark as asked here anymore
        this.saveData();
    }

    markQuestionAsAsked() {
        if (!this.currentQuestion) return;
        
        const questionIndex = this.questions.findIndex(q => q.id === this.currentQuestion.id);
        if (questionIndex === -1) return;

        this.questions[questionIndex].hasBeenAsked = true;
        this.saveData();
    }

    getAskedQuestions() {
        return this.questions
            .filter(q => q.hasBeenAsked)
            .sort((a, b) => (b.responseA + b.responseB) - (a.responseA + a.responseB));
    }

    resetAllData() {
        this.questions.forEach(q => {
            q.responseA = 0;
            q.responseB = 0;
            q.hasBeenAsked = false;
        });
        this.saveData();
        this.selectNextQuestion();
    }

    saveData() {
        try {
            localStorage.setItem('wouldYouRatherQuestions', JSON.stringify(this.questions));
        } catch (error) {
            console.error('Failed to save data:', error);
        }
    }

    loadData() {
        try {
            const saved = localStorage.getItem('wouldYouRatherQuestions');
            if (saved) {
                this.questions = JSON.parse(saved);
            }
        } catch (error) {
            console.error('Failed to load data:', error);
        }
    }

    getTotalResponses(question) {
        return question.responseA + question.responseB;
    }

    getPercentageA(question) {
        const total = this.getTotalResponses(question);
        return total > 0 ? (question.responseA / total * 100) : 0;
    }

    getPercentageB(question) {
        const total = this.getTotalResponses(question);
        return total > 0 ? (question.responseB / total * 100) : 0;
    }
}

// UI Controller
class App {
    constructor() {
        this.manager = new QuestionManager();
        this.initializeUI();
        this.attachEventListeners();
        this.renderQuestion();
    }

    initializeUI() {
        this.elements = {
            mainView: document.getElementById('main-view'),
            historyView: document.getElementById('history-view'),
            questionView: document.getElementById('question-view'),
            resultsView: document.getElementById('results-view'),
            optionA: document.getElementById('option-a'),
            optionB: document.getElementById('option-b'),
            submitBtn: document.getElementById('submit-btn'),
            skipQuestionBtn: document.getElementById('skip-question-btn'),
            newQuestionBtn: document.getElementById('new-question-btn'),
            hideResultsBtn: document.getElementById('hide-results-btn'),
            resetBtn: document.getElementById('reset-btn'),
            historyBtn: document.getElementById('history-btn'),
            doneBtn: document.getElementById('done-btn'),
            resetModal: document.getElementById('reset-modal'),
            cancelReset: document.getElementById('cancel-reset'),
            confirmReset: document.getElementById('confirm-reset'),
            historyList: document.getElementById('history-list'),
            historyEmpty: document.getElementById('history-empty')
        };
    }

    attachEventListeners() {
        this.elements.optionA.addEventListener('click', () => this.selectOption('A'));
        this.elements.optionB.addEventListener('click', () => this.selectOption('B'));
        this.elements.submitBtn.addEventListener('click', () => this.submitResponse());
        this.elements.skipQuestionBtn.addEventListener('click', () => this.skipQuestion());
        this.elements.newQuestionBtn.addEventListener('click', () => this.getNewQuestion());
        this.elements.hideResultsBtn.addEventListener('click', () => this.hideResultsAndKeepQuestion());
        this.elements.resetBtn.addEventListener('click', () => this.showResetModal());
        this.elements.historyBtn.addEventListener('click', () => this.showHistory());
        this.elements.doneBtn.addEventListener('click', () => this.hideHistory());
        this.elements.cancelReset.addEventListener('click', () => this.hideResetModal());
        this.elements.confirmReset.addEventListener('click', () => this.confirmReset());
    }

    selectOption(option) {
        this.manager.selectedOption = option;
        
        if (option === 'A') {
            this.elements.optionA.classList.add('selected');
            this.elements.optionB.classList.remove('selected');
        } else {
            this.elements.optionB.classList.add('selected');
            this.elements.optionA.classList.remove('selected');
        }

        this.elements.submitBtn.classList.remove('hidden');
    }

    submitResponse() {
        if (!this.manager.selectedOption) return;

        this.manager.recordResponse(this.manager.selectedOption);
        this.showResults();
        
        // Hide submit and skip buttons
        this.elements.submitBtn.classList.add('hidden');
        this.elements.skipQuestionBtn.classList.add('hidden');
    }

    skipQuestion() {
        // Get a new question without recording a response
        this.manager.selectNextQuestion();
        this.manager.selectedOption = null;
        this.renderQuestion();
    }

    getNewQuestion() {
        // Mark current question as asked and get a new one
        this.manager.markQuestionAsAsked();
        this.manager.selectNextQuestion();
        this.manager.selectedOption = null;
        this.renderQuestion();
        this.hideResults();
    }

    hideResultsAndKeepQuestion() {
        // Hide results but keep the same question for asking more people
        this.manager.selectedOption = null;
        this.hideResults();
        this.renderQuestion();
    }

    renderQuestion() {
        if (!this.manager.currentQuestion) return;

        const question = this.manager.currentQuestion;
        this.elements.optionA.querySelector('.option-text').textContent = question.optionA;
        this.elements.optionB.querySelector('.option-text').textContent = question.optionB;
        
        this.elements.optionA.classList.remove('selected');
        this.elements.optionB.classList.remove('selected');
        this.elements.submitBtn.classList.add('hidden');
        this.elements.skipQuestionBtn.classList.remove('hidden');
        
        // Re-enable option buttons for new question
        this.elements.optionA.disabled = false;
        this.elements.optionB.disabled = false;
    }

    showResults() {
        const question = this.manager.currentQuestion;
        const total = this.manager.getTotalResponses(question);
        const percentageA = this.manager.getPercentageA(question);
        const percentageB = this.manager.getPercentageB(question);

        // Update result cards
        const optionAResult = document.querySelector('.option-a-result');
        optionAResult.querySelector('.result-text').textContent = question.optionA;
        optionAResult.querySelector('.result-percentage').textContent = percentageA.toFixed(1) + '%';
        optionAResult.querySelector('.result-votes').textContent = question.responseA + ' votes';
        
        const optionBResult = document.querySelector('.option-b-result');
        optionBResult.querySelector('.result-text').textContent = question.optionB;
        optionBResult.querySelector('.result-percentage').textContent = percentageB.toFixed(1) + '%';
        optionBResult.querySelector('.result-votes').textContent = question.responseB + ' votes';

        document.querySelector('.total-responses').textContent = `Total Responses: ${total}`;

        // Disable option buttons after submission
        this.elements.optionA.disabled = true;
        this.elements.optionB.disabled = true;

        // Hide question view, show results view with buttons
        this.elements.questionView.classList.add('hidden');
        this.elements.resultsView.classList.remove('hidden');
        this.elements.hideResultsBtn.classList.remove('hidden');
        this.elements.newQuestionBtn.classList.remove('hidden');

        // Animate bars
        setTimeout(() => {
            optionAResult.querySelector('.result-bar').style.width = percentageA + '%';
            optionBResult.querySelector('.result-bar').style.width = percentageB + '%';
        }, 100);
    }

    hideResults() {
        this.elements.resultsView.classList.add('hidden');
        this.elements.questionView.classList.remove('hidden');
        this.elements.hideResultsBtn.classList.add('hidden');
        this.elements.newQuestionBtn.classList.add('hidden');
        
        // Reset bars
        document.querySelectorAll('.result-bar').forEach(bar => {
            bar.style.width = '0';
        });
    }

    showHistory() {
        const askedQuestions = this.manager.getAskedQuestions();
        
        if (askedQuestions.length === 0) {
            this.elements.historyList.innerHTML = '';
            this.elements.historyEmpty.classList.remove('hidden');
        } else {
            this.elements.historyEmpty.classList.add('hidden');
            this.renderHistory(askedQuestions);
        }

        this.elements.mainView.classList.add('slide-left');
        this.elements.historyView.classList.add('active');
    }

    hideHistory() {
        this.elements.mainView.classList.remove('slide-left');
        this.elements.historyView.classList.remove('active');
    }

    renderHistory(questions) {
        this.elements.historyList.innerHTML = questions.map(q => {
            const total = this.manager.getTotalResponses(q);
            const percentageA = this.manager.getPercentageA(q);
            const percentageB = this.manager.getPercentageB(q);

            return `
                <div class="history-card">
                    <div class="history-card-title">Would You Rather...</div>
                    <div class="history-option option-a">
                        <div class="history-dot option-a"></div>
                        <div class="history-option-text">${q.optionA}</div>
                        <div class="history-percentage">${percentageA.toFixed(0)}%</div>
                    </div>
                    <div class="history-option option-b">
                        <div class="history-dot option-b"></div>
                        <div class="history-option-text">${q.optionB}</div>
                        <div class="history-percentage">${percentageB.toFixed(0)}%</div>
                    </div>
                    <div class="history-divider"></div>
                    <div class="history-footer">
                        <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"/>
                            <circle cx="9" cy="7" r="4"/>
                            <path d="M23 21v-2a4 4 0 0 0-3-3.87"/>
                            <path d="M16 3.13a4 4 0 0 1 0 7.75"/>
                        </svg>
                        <span>${total} total responses</span>
                    </div>
                </div>
            `;
        }).join('');
    }

    showResetModal() {
        this.elements.resetModal.classList.remove('hidden');
    }

    hideResetModal() {
        this.elements.resetModal.classList.add('hidden');
    }

    confirmReset() {
        this.manager.resetAllData();
        this.renderQuestion();
        this.hideResetModal();
    }
}

// Initialize app when DOM is ready
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => new App());
} else {
    new App();
}
