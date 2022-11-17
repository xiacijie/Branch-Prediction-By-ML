void far() {
    return;
}

void baz() {
    return;
}

int foo(bool condition) {
    if (condition) {
        far();
        return 1;
    }
    else {
        baz();
        return 2;
    }
}

