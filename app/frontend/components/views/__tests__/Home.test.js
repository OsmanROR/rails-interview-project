import '@testing-library/jest-dom';
import React from 'react';
import { render, screen, waitFor } from '@testing-library/react';
import Home from '../home';

describe('Home Component', () => {
  test('fetches dashboard data and renders correctly', async () => {
    const mockDashboardData = {
      users_count: 5,
      questions_count: 15,
      answers_count: 25,
      tenant_api_request_counts: [
        { id: 1, name: 'Tenant X', api_request_count: 60 },
        { id: 2, name: 'Tenant Y', api_request_count: 70 },
      ],
    };

    global.fetch = jest.fn(() =>
      Promise.resolve({
        json: () => Promise.resolve(mockDashboardData),
      })
    );

    render(<Home />);

    await waitFor(() => {
      expect(screen.getByText('Users')).toBeInTheDocument();
      expect(screen.getByText('5')).toBeInTheDocument();
      expect(screen.getByText('Questions')).toBeInTheDocument();
      expect(screen.getByText('15')).toBeInTheDocument();
      expect(screen.getByText('Answers')).toBeInTheDocument();
      expect(screen.getByText('25')).toBeInTheDocument();

      expect(screen.getByText('Tenant X')).toBeInTheDocument();
      expect(screen.getByText('60')).toBeInTheDocument();
      expect(screen.getByText('Tenant Y')).toBeInTheDocument();
      expect(screen.getByText('70')).toBeInTheDocument();
    });

    expect(global.fetch).toHaveBeenCalledWith('/api/v1/dashboards');
  });
});
