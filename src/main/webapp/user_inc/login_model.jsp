<div class="sl_modal" id="sl_modal">
    <div class="modal_header">
        <img class="logo" src="../logo.png" alt="">
        <div class="row">
            <button data-onclick="h|.sign_up_content s|.log_in_content a|#login_open|active r|#signup_open|active" class="change_type react" id="login_open">Log in</button>
            <button data-onclick="s|.sign_up_content h|.log_in_content r|#login_open|active a|#signup_open|active" class="change_type react" id="signup_open">Sign up</button>
        </div><!-- row -->
    </div><!-- modal_header -->
    <div class="sign_up_content">
        <label for="username_signup">Username</label>
        <input type="text" id="username_signup" name="username">
        <label for="email_signup">Email</label>
        <input type="text" data-focus="h|.email-error" class="focus-input" id="email_signup" name="email">
        <p class="error-p email-error">Email is already used</p>
        <label for="password_signup">Password</label>
        <input type="password" data-focus="h|.password-error" class="focus-input" id="password_signup" name="password">
        <p class="error-p password-error">password should have At least 8 chars, one digit, one lower alpha char and one upper alpha char</p>
        <label for="confirm_password_signup">Confirm password</label>
        <input type="password" data-focus="h|.confirm-password-error" class="focus-input" id="confirm_password_signup" name="confirm_password">
        <p class="error-p confirm-password-error">Password and confirm password must be same</p>
        <button class="signup_submit submit_button" id="signup_submit">Sign up</button>
    </div><!-- sign_up_content -->
    <div class="log_in_content">
        <label for="email_login">Email</label>
        <input type="text" data-focus="h|.login-email-error" class="focus-input" id="email_login" name="email">
        <p class="error-p login-email-error">email is not used</p>
        <label for="password_login">Password</label>
        <input type="password" data-focus="h|.login-password-error" class="focus-input" id="password_login" name="password">
        <p class="error-p login-password-error">Password is wrong</p>
        <button class="login_submit submit_button" id="login_submit">Log in</button>
    </div><!-- log_in_content -->
</div><!-- sl_modal -->
<div data-onclick="r|.cover|open r|#sl_modal|open" class="cover react" id="cover"></div>