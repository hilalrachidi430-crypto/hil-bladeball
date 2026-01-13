import time
import random
import string
from selenium import webdriver
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

def generate_data(length=8):
    return ''.join(random.choice(string.ascii_letters + string.digits) for i in range(length))

def start_instagram_task():
    print("Initializing Samsung A50 Emulation...")
    
    my_target = "hawk.9465036"
    
    mobile_emulation = {
        "deviceMetrics": { "width": 412, "height": 892, "pixelRatio": 2.625 },
        "userAgent": "Mozilla/5.0 (Linux; Android 11; SM-A505F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.120 Mobile Safari/537.36"
    }
    
    chrome_options = Options()
    chrome_options.add_experimental_option("mobileEmulation", mobile_emulation)
    # chrome_options.add_argument("--headless") # Enable this for Cloud servers
    
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=chrome_options)
    wait = WebDriverWait(driver, 15)
    
    try:
        # STEP 1: REGISTRATION
        print("Navigating to Signup Page...")
        driver.get("https://www.instagram.com/accounts/emailsignup/")
        time.sleep(5)
        
        # [Registration logic will happen here - requires Manual or Proxy bypass]
        print("Account Creation in progress...")
        
        # STEP 2: GO TO YOUR PROFILE
        print(f"Navigating to profile: {my_target}")
        driver.get(f"https://www.instagram.com/{my_target}/")
        
        # STEP 3: CLICK FOLLOW
        print("Searching for Follow button...")
        # This searches for the 'Follow' button in the Mobile UI
        follow_btn = wait.until(EC.element_to_be_clickable((By.XPATH, "//button[contains(text(), 'Follow')]")))
        follow_btn.click()
        
        print(f"Successfully followed {my_target}!")
        time.sleep(5)

    except Exception as e:
        print(f"System Alert: {e}")
    
    finally:
        driver.quit()
        print("Bot Session Closed.")

if __name__ == "__main__":
    start_instagram_task()