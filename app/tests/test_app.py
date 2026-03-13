import pytest
from app import app
 
@pytest.fixture
def client():
    app.config['TESTING'] = True
    # Establish an application context before yielding the client
    with app.app_context():
        with app.test_client() as client:
            yield client


def test_home(client):
    """Test the home endpoint"""
    response = client.get('/')
    assert response.status_code == 200
    assert b'Welcome to FinOps App' in response.data
 
def test_health(client):
    """Test the health check endpoint"""
    response = client.get('/health')
    assert response.status_code == 200
    data = response.get_json()
    assert data['status'] == 'ok'
 
def test_calculate(client):
    """Test the calculate endpoint"""
    response = client.get('/api/calculate')
    assert response.status_code == 200
    data = response.get_json()
    assert data['result'] == 30