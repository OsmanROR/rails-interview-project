import React, { useEffect, useState } from 'react';
import { Container, Row, Col, Card, Table } from 'react-bootstrap';

function Home() {
  const [dashboardData, setDashboardData] = useState({
    users_count: 0,
    questions_count: 0,
    answers_count: 0,
    tenant_api_request_counts: [],
  });

  useEffect(() => {
    fetch('/api/v1/dashboards')
      .then(response => response.json())
      .then(data => setDashboardData(data));
  }, []);

  return (
    <Container className="mt-5">
      <Row>
        <Col md={4}>
          <Card className='bg-info text-white'>
            <Card.Body>
              <Card.Title>Users</Card.Title>
              <Card.Text>{dashboardData.users_count}</Card.Text>
            </Card.Body>
          </Card>
        </Col>
        <Col md={4}>
          <Card className='bg-primary text-white'>
            <Card.Body>
              <Card.Title>Questions</Card.Title>
              <Card.Text>{dashboardData.questions_count}</Card.Text>
            </Card.Body>
          </Card>
        </Col>
        <Col md={4}>
          <Card className='bg-success text-white'>
            <Card.Body>
              <Card.Title>Answers</Card.Title>
              <Card.Text>{dashboardData.answers_count}</Card.Text>
            </Card.Body>
          </Card>
        </Col>
      </Row>
      <br/>
      <Row>
      <Col md={12}>
          <Card>
            <Card.Body>
              <Card.Title>Tenant API Requests</Card.Title>
              <Table>
                <thead>
                  <tr>
                    <th>#</th>
                    <th>Tenant Name</th>
                    <th>API Request Count</th>
                  </tr>
                </thead>
                <tbody>
                  {dashboardData.tenant_api_request_counts.map((tenant, index) => (
                    <tr key={tenant.id}>
                      <td>{index + 1}</td>
                      <td>{tenant.name}</td>
                      <td>{tenant.api_request_count}</td>
                    </tr>
                  ))}
                </tbody>
              </Table>
            </Card.Body>
          </Card>
        </Col>
      </Row>
    </Container>
  );
}

export default Home;
